#!/bin/bash
set -euo pipefail

VERSION="${VERSION:-"latest"}"
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


install_kubectl() {
  if [ "$VERSION" = "latest" ]; then
    VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt)
  else
    VERSION="v${VERSION}"
  fi
  local url="https://dl.k8s.io/release/${VERSION}/bin/$(get_os)/$(get_arch)/kubectl"
  curl -Lo /usr/local/bin/kubectl "$url" && chmod +x /usr/local/bin/kubectl
}

install_completions() {
  echo "source <(kubectl completion zsh)" >> "${_REMOTE_USER_HOME}/.zshrc"
  echo "source <(kubectl completion zsh)" >> "${_CONTAINER_USER_HOME}/.zshrc"
}

install_kubectl
install_completions
