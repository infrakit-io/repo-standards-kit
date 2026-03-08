#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
INFRAKIT_ROOT="${INFRAKIT_ROOT:-$HOME/work/Bibi40k-GIT/infrakit-io}"
VMWARE_SOURCE_REPO="${VMWARE_SOURCE_REPO:-$INFRAKIT_ROOT/vmware-vm-bootstrap}"
TALOS_SOURCE_REPO="${TALOS_SOURCE_REPO:-$INFRAKIT_ROOT/talos-docker-bootstrap}"

copy_profile() {
  local profile="$1"
  local source_repo="$2"
  local manifest="$ROOT_DIR/profiles/$profile.manifest"
  local target_dir="$ROOT_DIR/templates/profiles/$profile"

  if [[ ! -d "$source_repo" ]]; then
    echo "source repo missing: $source_repo" >&2
    exit 1
  fi

  while IFS= read -r rel; do
    [[ -z "$rel" || "$rel" =~ ^# ]] && continue
    local src="$source_repo/$rel"
    local dst="$target_dir/$rel"
    if [[ ! -f "$src" ]]; then
      echo "missing source file: $src" >&2
      exit 1
    fi
    mkdir -p "$(dirname "$dst")"
    cp "$src" "$dst"
    if [[ -x "$src" ]]; then
      chmod +x "$dst"
    fi
    echo "refreshed: $profile/$rel"
  done < "$manifest"
}

copy_profile "vmware" "$VMWARE_SOURCE_REPO"
copy_profile "talos" "$TALOS_SOURCE_REPO"

echo "All templates refreshed from source repos."
