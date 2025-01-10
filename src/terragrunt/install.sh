#!/bin/bash
set -euo pipefail

BIN_DIR="${BIN_DIR:-"/usr/local/bin"}"
VERSION="${VERSION:-"0.71.1"}"


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
      *) echo "Unsupported architecture: ${arch}"; exit 1 ;;
  esac
  echo "${arch}"
}

install_terragrunt() {
  local url
  url="https://github.com/gruntwork-io/terragrunt/releases/download/v${VERSION}/terragrunt_$(get_os)_$(get_arch)"
  curl -Lo "${BIN_DIR}/terragrunt" "${url}" && chmod +x "${BIN_DIR}/terragrunt"
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
