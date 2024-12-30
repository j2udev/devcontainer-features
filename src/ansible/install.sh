#!/bin/bash
set -e

VERSION="${VERSION:-"11.1.0"}"
INSTALL_PIPX="${INSTALL_PIPX:-"true"}"

install_pipx() {
  apt update && apt install -y pipx
}

install_ansible() {
  export PIPX_HOME=/opt
  export PIPX_BIN_DIR=/usr/local/bin
  pipx install ansible=="${VERSION}" --include-deps
}

if [ "$INSTALL_PIPX" = "true" ]; then
  install_pipx
fi
install_ansible
