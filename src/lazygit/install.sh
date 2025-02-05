#!/bin/bash
set -euo pipefail

BIN_DIR="${BIN_DIR:-"/usr/local/bin"}"
VERSION="${VERSION:-"0.44.1"}"
ENABLE_CONFIG="${ENABLE_CONFIG:-"true"}"
ENABLE_ALIAS="${ENABLE_ALIAS:-"true"}"
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
  aarch64) arch="arm64" ;;
  *)
    echo "Unsupported architecture: ${arch}"
    exit 1
    ;;
  esac
  echo "${arch}"
}

install_lazygit() {
  local url
  url="https://github.com/jesseduffield/lazygit/releases/download/v${VERSION}/lazygit_${VERSION}_$(get_os)_$(get_arch).tar.gz"
  curl -L "${url}" | tar xzf - -C "${BIN_DIR}" --wildcards 'lazygit' && chmod +x "${BIN_DIR}/lazygit"
}

configure_lazygit() {
  for shell in "${shells[@]}"; do
    for home in "${homes[@]}"; do
      mkdir -p "${home}/.config/lazygit"
      cp config.yml "${home}/.config/lazygit/config.yml"
      if [ "$ENABLE_ALIAS" = "true" ]; then
        echo "alias lzg='lazygit'" >> "${home}/.${shell}rc"
      fi
    done
  done
}

install_lazygit
configure_lazygit
