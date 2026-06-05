#!/usr/bin/env bash
set -euo pipefail

# Bootstrap-stage lint: just typecheck every library entry point.
fail=0
for entry in libs/*/src/*.nim; do
  if [[ -f "${entry}" ]]; then
    if ! nim check --hints:off --warnings:off "${entry}" >/dev/null 2>&1; then
      printf '  [FAIL] nim check %s\n' "${entry}" >&2
      fail=1
    else
      printf '  [OK]   nim check %s\n' "${entry}"
    fi
  fi
done

if (( fail != 0 )); then
  exit 1
fi
