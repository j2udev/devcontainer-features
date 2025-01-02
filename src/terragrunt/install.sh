#!/bin/bash
set -x

VERSION="${VERSION:-"0.71.1"}"

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

install_terragrunt() {
  local os_arch=$(detect_os_arch)
  local url="https://github.com/gruntwork-io/terragrunt/releases/download/v${VERSION}/terragrunt_${os_arch}"
  curl -Lo /usr/local/bin/terragrunt "$url" && chmod +x /usr/local/bin/terragrunt
}

install_completion() {
  if ! grep -Fxq "autoload -U +X bashcompinit && bashcompinit" "$1"; then
    echo "autoload -U +X bashcompinit && bashcompinit" >> "$1"
  fi
  echo "complete -o nospace -C /usr/local/bin/terragrunt terragrunt" >> "$1"
}

install_completions() {
  install_completion "${_REMOTE_USER_HOME}/.zshrc"
  install_completion "${_CONTAINER_USER_HOME}/.zshrc"
  install_completion "${_REMOTE_USER_HOME}/.bashrc"
  install_completion "${_CONTAINER_USER_HOME}/.bashrc"
}

install_terragrunt
install_completions
