#!/bin/bash
set -x

VERSION="${VERSION:-"3.16.4"}"
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


install_helm() {
  local url="https://get.helm.sh/helm-v${VERSION}-$(get_os)-$(get_arch).tar.gz"
  curl -L "$url" | tar xzf - -C /opt && ln -s /opt/$(get_os)-$(get_arch)/helm /usr/local/bin/helm
}

install_completions() {
  echo "source <(helm completion zsh)" >> "${_REMOTE_USER_HOME}/.zshrc"
  echo "source <(helm completion zsh)" >> "${_CONTAINER_USER_HOME}/.zshrc"
}

install_helm
install_completions
