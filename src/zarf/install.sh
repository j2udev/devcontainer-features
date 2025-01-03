#!/bin/bash
set -euo pipefail

VERSION="${VERSION:-"0.45.0"}"
_REMOTE_USER_HOME="${_REMOTE_USER_HOME:-"/home/vscode"}"
_CONTAINER_USER_HOME="${_CONTAINER_USER_HOME:-"/home/vscode"}"

get_os() {
  local os="$(uname | tr '[:upper:]' '[:lower:]')"
  echo "$os"
}

get_arch() {
  local arch="$(uname -m)"
  case "$arch" in
      x86_64) arch="amd64" ;;
      armv8*|aarch64) arch="arm64" ;;
      *) echo "Unsupported architecture: ${arch}"; exit 1 ;;
  esac
  echo "$arch"
}


install_zarf() {
  local url="https://github.com/zarf-dev/zarf/releases/download/v${VERSION}/zarf_v${VERSION}_$(get_os)_$(get_arch)"
  curl -Lo /usr/local/bin/zarf "$url" && chmod +x /usr/local/bin/zarf
}

install_completions() {
  echo "source <(zarf completion zsh)" >> "${_REMOTE_USER_HOME}/.zshrc"
  echo "source <(zarf completion zsh)" >> "${_CONTAINER_USER_HOME}/.zshrc"
}

install_zarf
install_completions
