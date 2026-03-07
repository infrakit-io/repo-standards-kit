#!/usr/bin/env bash
set -euo pipefail

topic="${1:-}"
project="${2:-$(basename "$(pwd)")}"
infra_kb_root="${3:-$(cd ../infra-knowledge-base 2>/dev/null && pwd || true)}"

if [[ -z "$topic" ]]; then
  echo "usage: $0 <topic> [project] [infra_kb_root]" >&2
  exit 1
fi

if [[ -z "$infra_kb_root" ]]; then
  echo "[standards-check] FAILED: infra knowledge base root not provided/found" >&2
  exit 1
fi

cd "$(git rev-parse --show-toplevel)"

echo "[standards-check] decision context for topic: $topic"
out="$(bash "$infra_kb_root/scripts/decision-check.sh" "$topic" "$project")"
printf "%s\n" "$out"
if ! printf "%s\n" "$out" | grep -q "Status: OK"; then
  echo "[standards-check] FAILED: missing decision context for topic '$topic'" >&2
  exit 1
fi

echo "[standards-check] decision contract checks"
make decision-contract-check

echo "[standards-check] security policy checks"
make security-check

echo "[standards-check] OK"
