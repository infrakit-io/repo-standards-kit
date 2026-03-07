#!/usr/bin/env bash
set -euo pipefail

cd "$(git rev-parse --show-toplevel)"

fail=0

echo "[decision-contract-check] enforcing wizard/menu contract..."

mapfile -t manager_files < <(find cmd -type f -name '*manager.go' 2>/dev/null | sort)
if [[ "${#manager_files[@]}" -eq 0 ]]; then
  echo "  FAIL: no *manager.go files found under cmd/"
  echo "[decision-contract-check] FAILED"
  exit 1
fi

if command -v rg >/dev/null 2>&1; then
  rg -n 'survey\.AskOne\(&survey\.Select' "${manager_files[@]}" >/tmp/decision-contract.matches 2>/dev/null || true
else
  grep -nE 'survey\.AskOne\(&survey\.Select' "${manager_files[@]}" >/tmp/decision-contract.matches || true
fi
if [[ -s /tmp/decision-contract.matches ]]; then
  echo "  FAIL: manager flows must use shared interactiveSelect, not survey.Select directly:"
  sed -n '1,120p' /tmp/decision-contract.matches
  fail=1
fi

if command -v rg >/dev/null 2>&1; then
  rg -n 'preview only|Show config|Open in editor' "${manager_files[@]}" >/tmp/decision-contract.labels 2>/dev/null || true
else
  grep -nE 'preview only|Show config|Open in editor' "${manager_files[@]}" >/tmp/decision-contract.labels || true
fi
if [[ -s /tmp/decision-contract.labels ]]; then
  echo "  FAIL: forbidden non-standard menu labels detected:"
  sed -n '1,120p' /tmp/decision-contract.labels
  fail=1
fi

if command -v rg >/dev/null 2>&1; then
  rg -n 'interactiveSelect\(' "${manager_files[@]}" >/tmp/decision-contract.interactive 2>/dev/null || true
else
  grep -n 'interactiveSelect(' "${manager_files[@]}" >/tmp/decision-contract.interactive || true
fi
if [[ ! -s /tmp/decision-contract.interactive ]]; then
  echo "  FAIL: manager flows missing interactiveSelect usage."
  fail=1
fi

rm -f /tmp/decision-contract.matches /tmp/decision-contract.labels /tmp/decision-contract.interactive

if [[ "$fail" -ne 0 ]]; then
  echo "[decision-contract-check] FAILED"
  exit 1
fi

echo "[decision-contract-check] OK"
