#!/usr/bin/env bash
set -euo pipefail

cd "$(git rev-parse --show-toplevel)"

fail=0

echo "[security-check] scanning tracked .sops.yaml files for SOPS metadata..."
while IFS= read -r path; do
  [[ -z "$path" ]] && continue
  if ! grep -Eq '^[[:space:]]*sops:' "$path"; then
    echo "  FAIL: missing SOPS metadata in $path"
    fail=1
  fi
done < <(git ls-files '*.sops.yaml')

echo "[security-check] checking for staged decrypted secret files..."
if git diff --cached --name-only | grep -q '\.decrypted~'; then
  echo "  FAIL: attempting to commit decrypted SOPS files"
  git diff --cached --name-only | grep '\.decrypted~'
  fail=1
fi

echo "[security-check] scanning code for forbidden direct in-place encryption patterns..."
if command -v rg >/dev/null 2>&1; then
  rg -n 'sops".*"--encrypt".*"--in-place"|sops.*,.*--encrypt.*,.*--in-place' cmd >/tmp/security-check.matches 2>/dev/null || true
else
  grep -RInE 'sops".*"--encrypt".*"--in-place"|sops.*,.*--encrypt.*,.*--in-place' cmd >/tmp/security-check.matches 2>/dev/null || true
fi
if [[ -s /tmp/security-check.matches ]]; then
  echo "  FAIL: found forbidden direct sops --encrypt --in-place usage:"
  sed -n '1,120p' /tmp/security-check.matches
  fail=1
fi
rm -f /tmp/security-check.matches

if [[ "$fail" -ne 0 ]]; then
  echo "[security-check] FAILED"
  exit 1
fi

echo "[security-check] OK"
