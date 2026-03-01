#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<USAGE
Usage: $0 --profile <name> --target <repo_path> [--with-git] [--commit]

Examples:
  $0 --profile vmware --target ../my-vmware-repo --with-git --commit
  $0 --profile go-library --target ../my-lib --with-git
USAGE
}

PROFILE=""
TARGET=""
WITH_GIT=0
WITH_COMMIT=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --profile) PROFILE="${2:-}"; shift 2 ;;
    --target) TARGET="${2:-}"; shift 2 ;;
    --with-git) WITH_GIT=1; shift ;;
    --commit) WITH_COMMIT=1; shift ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown arg: $1" >&2; usage; exit 1 ;;
  esac
done

if [[ -z "$PROFILE" || -z "$TARGET" ]]; then
  usage
  exit 1
fi

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SYNC_SCRIPT="$ROOT_DIR/scripts/sync-profile.sh"

mkdir -p "$TARGET"
TARGET_ABS="$(cd "$TARGET" && pwd)"

if [[ "$WITH_GIT" -eq 1 && ! -d "$TARGET_ABS/.git" ]]; then
  git -C "$TARGET_ABS" init -b master >/dev/null
fi

"$SYNC_SCRIPT" --profile "$PROFILE" --target "$TARGET_ABS"

if [[ "$WITH_COMMIT" -eq 1 ]]; then
  if [[ ! -d "$TARGET_ABS/.git" ]]; then
    echo "Cannot commit: $TARGET_ABS is not a git repository (use --with-git)." >&2
    exit 1
  fi
  git -C "$TARGET_ABS" add -A
  if ! git -C "$TARGET_ABS" diff --cached --quiet; then
    git -C "$TARGET_ABS" commit -m "chore: apply repo-standards-kit profile ($PROFILE)" >/dev/null
    echo "Committed initial profile in $TARGET_ABS"
  else
    echo "No changes to commit in $TARGET_ABS"
  fi
fi

echo "Initialized repository with profile '$PROFILE': $TARGET_ABS"
