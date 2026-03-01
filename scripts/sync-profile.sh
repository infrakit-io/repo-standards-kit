#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<USAGE
Usage: $0 --profile <name> --target <repo_path> [--dry-run]

Profiles:
  vmware
  talos
  go-library
USAGE
}

PROFILE=""
TARGET=""
DRY_RUN=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --profile) PROFILE="${2:-}"; shift 2 ;;
    --target) TARGET="${2:-}"; shift 2 ;;
    --dry-run) DRY_RUN=1; shift ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown arg: $1" >&2; usage; exit 1 ;;
  esac
done

if [[ -z "$PROFILE" || -z "$TARGET" ]]; then
  usage
  exit 1
fi

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC_DIR="$ROOT_DIR/templates/profiles/$PROFILE"
MANIFEST="$ROOT_DIR/profiles/$PROFILE.manifest"

if [[ ! -d "$SRC_DIR" ]]; then
  echo "Profile not found: $PROFILE" >&2
  exit 1
fi
if [[ ! -f "$MANIFEST" ]]; then
  echo "Manifest not found: $MANIFEST" >&2
  exit 1
fi
if [[ ! -d "$TARGET" ]]; then
  echo "Target repo not found: $TARGET" >&2
  exit 1
fi

while IFS= read -r rel; do
  [[ -z "$rel" || "$rel" =~ ^# ]] && continue
  src="$SRC_DIR/$rel"
  dst="$TARGET/$rel"

  if [[ ! -f "$src" ]]; then
    echo "Missing template file: $src" >&2
    exit 1
  fi

  if [[ "$DRY_RUN" -eq 1 ]]; then
    echo "[dry-run] $src -> $dst"
    continue
  fi

  mkdir -p "$(dirname "$dst")"
  cp "$src" "$dst"
  if [[ -x "$src" ]]; then
    chmod +x "$dst"
  fi
  echo "synced: $rel"
done < "$MANIFEST"

echo "Profile '$PROFILE' synced to $TARGET"
