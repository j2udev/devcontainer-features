#!/bin/bash
set -euo pipefail

VERSION="${VERSION:-"1.11.2"}"
BIN_DIR="${BIN_DIR:-"/usr/local/bin"}"

get_os() {
  local os="$(uname | tr '[:upper:]' '[:lower:]')"
  echo "${os}"
}

get_arch() {
  local arch="$(uname -m)"
  case "$arch" in
      x86_64) arch="amd64" ;;
      armv8*|aarch64) arch="arm64" ;;
      *) echo "Unsupported architecture: ${arch}"; exit 1 ;;
  esac
  echo "${arch}"
}

install_packer() {
  local url="https://releases.hashicorp.com/packer/${VERSION}/packer_${VERSION}_$(get_os)_$(get_arch).zip"
  curl -L "$url" > /tmp/packer.zip && unzip -qod "$BIN_DIR" /tmp/packer.zip "packer"
}

install_completion() {
  if ! grep -Fxq "autoload -U +X bashcompinit && bashcompinit" "$1"; then
    echo "autoload -U +X bashcompinit && bashcompinit" >> "$1"
  fi
  echo "complete -o nospace -C /usr/local/bin/packer packer" >> "$1"
}

install_completions() {
  install_completion "${_REMOTE_USER_HOME}/.zshrc"
  install_completion "${_CONTAINER_USER_HOME}/.zshrc"
  install_completion "${_REMOTE_USER_HOME}/.bashrc"
  install_completion "${_CONTAINER_USER_HOME}/.bashrc"
}

install_packer
install_completions
