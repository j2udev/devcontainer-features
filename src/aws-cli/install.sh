#!/bin/bash
set -euo pipefail

BIN_DIR="${BIN_DIR:-"/usr/local/bin"}"
INSTALL_DIR="${INSTALL_DIR:-"/opt"}"
_REMOTE_USER_HOME="${_REMOTE_USER_HOME:-"/home/vscode"}"
_CONTAINER_USER_HOME="${_CONTAINER_USER_HOME:-"/home/vscode"}"

get_os() {
  local os="$(uname | tr '[:upper:]' '[:lower:]')"
  echo "${os}"
}

get_arch() {
  local arch="$(uname -m)"
  case "$arch" in
      x86_64) arch="x86_64" ;;
      aarch64) arch="aarch64" ;;
      *) echo "Unsupported architecture: ${arch}"; exit 1 ;;
  esac
  echo "${arch}"
}


install_aws_cli() {
  curl -Lo /tmp/awscliv2.zip https://awscli.amazonaws.com/awscli-exe-$(get_os)-$(get_arch).zip \
    && unzip -qod "$INSTALL_DIR" /tmp/awscliv2.zip \
    && "${INSTALL_DIR}/aws/install" -b "$BIN_DIR" -i "$INSTALL_DIR" --update
}

install_completion() {
  echo "complete -C aws_completer aws" >> "$1"
}

install_completions() {
  install_completion "${_REMOTE_USER_HOME}/.zshrc"
  install_completion "${_CONTAINER_USER_HOME}/.zshrc"
  install_completion "${_REMOTE_USER_HOME}/.bashrc"
  install_completion "${_CONTAINER_USER_HOME}/.bashrc"
}

install_aws_cli
install_completions
