#!/bin/bash
set -euo pipefail
source dev-container-features-test-lib
source helpers.sh
check "check theme" check_theme
reportResults