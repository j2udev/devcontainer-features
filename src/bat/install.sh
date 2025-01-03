#!/bin/bash
set -euo pipefail

BIN_DIR="${BIN_DIR:-"/usr/local/bin"}"
INSTALL_DIR="${INSTALL_DIR:-"/opt"}"
VERSION="${VERSION:-"0.24.0"}"
THEME="${THEME:-"default"}"

get_os() {
  local os="$(uname | tr '[:upper:]' '[:lower:]')"
  echo "${os}"
}

get_arch() {
  local arch="$(uname -m)"
  case "$arch" in
      x86_64) arch="x86_64" ;;
      aarch64) arch="aarch64" ;;
      *) echo "Unsupported architecture: ${arch}"; exit 1 ;;
  esac
  echo "${arch}"
}

install_bat() {
  local url="https://github.com/sharkdp/bat/releases/download/v${VERSION}/bat-v${VERSION}-$(get_arch)-unknown-$(get_os)-gnu.tar.gz"
  curl -L "$url" | tar xzf - -C /opt && ln -s "${INSTALL_DIR}/bat-v${VERSION}-$(get_arch)-unknown-$(get_os)-gnu/bat" "${BIN_DIR}/bat"
}

install_aliases() {
  echo "alias bat='bat --theme=${THEME}'" >> "$1"
  echo "alias cat='bat -Pp --theme=${THEME}'" >> "$1"
}

configure_bat() {
  install_aliases "${_REMOTE_USER_HOME}/.bashrc"
  install_aliases "${_CONTAINER_USER_HOME}/.bashrc"
  install_aliases "${_REMOTE_USER_HOME}/.zshrc"
  install_aliases "${_CONTAINER_USER_HOME}/.zshrc"
}

install_bat
configure_bat
