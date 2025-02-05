#!/bin/bash
set -euo pipefail

BIN_DIR="${BIN_DIR:-"/usr/local/bin"}"
VERSION="${VERSION:-"0.57.0"}"
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
  x86_64) arch="amd64" ;;
  aarch64) arch="arm64" ;;
  *)
    echo "Unsupported architecture: ${arch}"
    exit 1
    ;;
  esac
  echo "${arch}"
}

install_fzf() {
  local url
  url="https://github.com/junegunn/fzf/releases/download/v${VERSION}/fzf-${VERSION}-$(get_os)_$(get_arch).tar.gz"
  curl -L "${url}" | sudo tar xzf - -C "${BIN_DIR}" --wildcards 'fzf' && chmod +x "${BIN_DIR}/fzf"
}

configure_fzf() {
  for shell in "${shells[@]}"; do
    for home in "${homes[@]}"; do
      echo "source <(fzf --${shell})" >> "${home}/.${shell}rc"
    done
  done
}

install_fzf
configure_fzf
