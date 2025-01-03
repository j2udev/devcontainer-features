#!/bin/bash
set -euo pipefail

BIN_DIR="${BIN_DIR:-"/usr/local/bin"}"
INSTALL_DIR="${INSTALL_DIR:-"/opt"}"
VERSION="${VERSION:-"11.1.0"}"
INSTALL_PIPX="${INSTALL_PIPX:-"true"}"

install_pipx() {
  apt update && apt install -y pipx
}

install_ansible() {
  export PIPX_HOME="$INSTALL_DIR"
  export PIPX_BIN_DIR="$BIN_DIR"
  pipx install ansible=="${VERSION}" --include-deps
}

if [ "$INSTALL_PIPX" = "true" ]; then
  install_pipx
fi
install_ansible
