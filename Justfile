set shell := ["bash", "-eu", "-o", "pipefail", "-c"]

default:
    just lint

build:
    @echo "No apps to build yet — ct-test ships libraries only at this stage."
    @echo "Future: builds apps/ct-test-runner/."

test:
    mkdir -p test-logs
    bash scripts/run_tests.sh 2>&1 | tee test-logs/test.log

t: test

lint:
    mkdir -p test-logs
    bash scripts/check_nim_sources.sh 2>&1 | tee test-logs/lint.log

format:
    @echo "No formatter wired up yet."

fmt: format
