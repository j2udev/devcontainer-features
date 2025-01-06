#!/bin/bash
set -euo pipefail

VERSION="${VERSION:-"0.10.0"}"
BIN_DIR="${BIN_DIR:-"/usr/local/bin"}"
INSTALL_DIR="${INSTALL_DIR:-"/opt"}"
_REMOTE_USER_HOME="${_REMOTE_USER_HOME:-"/home/vscode"}"
_CONTAINER_USER_HOME="${_CONTAINER_USER_HOME:-"/home/vscode"}"

get_os() {
  local os
  os="$(uname | tr '[:upper:]' '[:lower:]')"
  echo "${os}"
}

get_arch() {
  local arch
  arch="$(uname -m)"
  case "${arch}" in
      x86_64) arch="x86_64" ;;
      aarch64) arch="aarch64" ;;
      *) echo "Unsupported architecture: ${arch}"; exit 1 ;;
  esac
  echo "${arch}"
}


install_shellcheck() {
  local url
  url="https://github.com/koalaman/shellcheck/releases/download/v${VERSION}/shellcheck-v${VERSION}.$(get_os).$(get_arch).tar.xz"
  curl -L "${url}" | tar xJf - -C "${INSTALL_DIR}" \
    && ln -sf "${INSTALL_DIR}/shellcheck-v${VERSION}/shellcheck" "${BIN_DIR}/shellcheck"
}

install_shellcheck
