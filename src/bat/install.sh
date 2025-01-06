#!/bin/bash
set -euo pipefail

BIN_DIR="${BIN_DIR:-"/usr/local/bin"}"
INSTALL_DIR="${INSTALL_DIR:-"/opt"}"
VERSION="${VERSION:-"0.24.0"}"
THEME="${THEME:-"default"}"
_REMOTE_USER_HOME="${_REMOTE_USER_HOME:-"/home/vscode"}"
_CONTAINER_USER_HOME="${_CONTAINER_USER_HOME:-"/home/vscode"}"

shells=("zsh" "bash")
homes=("${_REMOTE_USER_HOME}" "${_CONTAINER_USER_HOME}")

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

install_bat() {
  local url
  url="https://github.com/sharkdp/bat/releases/download/v${VERSION}/bat-v${VERSION}-$(get_arch)-unknown-$(get_os)-gnu.tar.gz"
  curl -L "${url}" | tar xzf - -C /opt \
    && ln -sf "${INSTALL_DIR}/bat-v${VERSION}-$(get_arch)-unknown-$(get_os)-gnu/bat" "${BIN_DIR}/bat"
}

configure_bat() {
  for shell in "${shells[@]}"; do
    for home in "${homes[@]}"; do
      echo "alias bat='bat --theme=${THEME}'" >> "${home}/.${shell}rc"
      echo "alias cat='bat -Pp --theme=${THEME}'" >> "${home}/.${shell}rc"
    done
  done
}

install_bat
configure_bat
