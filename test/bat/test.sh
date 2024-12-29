#!/bin/bash
set -e

# Optional: Import test library bundled with the devcontainer CLI
# See https://github.com/devcontainers/cli/blob/HEAD/docs/features/test.md#dev-container-features-test-lib
# Provides the 'check' and 'reportResults' commands.
source dev-container-features-test-lib

# Feature-specific tests
source helpers.sh
check "check bat" check_bat

# Report results
# If any of the checks above exited with a non-zero exit code, the test will fail.
reportResults