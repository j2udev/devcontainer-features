#!/bin/bash
set -x
source dev-container-features-test-lib
source helpers.sh
check "check neovim version" check_neovim_version
reportResults