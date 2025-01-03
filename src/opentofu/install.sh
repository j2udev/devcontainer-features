#!/bin/bash
set -euo pipefail

VERSION="${VERSION:-"1.8.8"}"

detect_os_arch() {
  OS="$(uname | tr '[:upper:]' '[:lower:]')"
  ARCH="$(uname -m)"

  case $ARCH in
      x86_64) ARCH="amd64" ;;
      armv8*|aarch64) ARCH="arm64" ;;
      *) echo "Unsupported architecture: $ARCH"; exit 1 ;;
  esac

  echo "${OS}_${ARCH}"
}

install_opentofu() {
  local os_arch=$(detect_os_arch)
  local url="https://github.com/opentofu/opentofu/releases/download/v${VERSION}/tofu_${VERSION}_${os_arch}.tar.gz"
  curl -L "$url" | tar xzf - -C /usr/local/bin
}

install_completion() {
  if ! grep -Fxq "autoload -U +X bashcompinit && bashcompinit" "$1"; then
    echo "autoload -U +X bashcompinit && bashcompinit" >> "$1"
  fi
  echo "complete -o nospace -C /usr/local/bin/tofu tofu" >> "$1"
}

install_completions() {
  install_completion "${_REMOTE_USER_HOME}/.zshrc"
  install_completion "${_CONTAINER_USER_HOME}/.zshrc"
  install_completion "${_REMOTE_USER_HOME}/.bashrc"
  install_completion "${_CONTAINER_USER_HOME}/.bashrc"
}

install_opentofu
install_completions
