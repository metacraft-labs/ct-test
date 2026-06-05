#!/usr/bin/env bash
set -euo pipefail

mkdir -p build/test-bin build/nimcache

found=0
failed_tests=()

while IFS= read -r -d '' test_file; do
  found=1
  test_name="$(basename "${test_file}" .nim)"
  set +e
  nim c -r \
    --threads:on \
    --hints:off \
    --warnings:off \
    --nimcache:"build/nimcache/${test_name}" \
    --out:"build/test-bin/${test_name}" \
    "${test_file}"
  test_rc=$?
  set -e
  if (( test_rc != 0 )); then
    failed_tests+=("${test_file}")
  fi
done < <(
  find tests libs -path '*/tests/t_*.nim' -type f -print0 2>/dev/null
  find tests -name 't_*.nim' -type f -print0 2>/dev/null
)

if [ "${found}" -eq 0 ]; then
  echo "no Nim tests found" >&2
  exit 0
fi

if (( ${#failed_tests[@]} > 0 )); then
  printf '\n========== FAILED TESTS (%d) ==========\n' "${#failed_tests[@]}" >&2
  for t in "${failed_tests[@]}"; do
    printf '  %s\n' "$t" >&2
  done
  exit 1
fi
