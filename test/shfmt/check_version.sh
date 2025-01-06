#!/bin/bash
set -euo pipefail
source dev-container-features-test-lib
source helpers.sh
check "check version" check_version
reportResults
