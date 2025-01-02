#!/bin/bash
set -x

VERSION="${VERSION:-"2.35.0"}"
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


install_direnv() {
  local url="https://github.com/direnv/direnv/releases/download/v${VERSION}/direnv.$(get_os)-$(get_arch)"
  curl -Lo /usr/local/bin/direnv "$url" && chmod +x /usr/local/bin/direnv
  echo "eval \"\$(direnv hook zsh)\"" >> "${_REMOTE_USER_HOME}/.zshrc"
  echo "eval \"\$(direnv hook zsh)\"" >> "${_CONTAINER_USER_HOME}/.zshrc"
  echo "eval \"\$(direnv hook zsh)\"" >> "${_REMOTE_USER_HOME}/.bashrc"
  echo "eval \"\$(direnv hook zsh)\"" >> "${_CONTAINER_USER_HOME}/.bashrc"
}

configure_direnv() {
  mkdir -p "${_REMOTE_USER_HOME}/.config/direnv"
  mkdir -p "${_CONTAINER_USER_HOME}/.config/direnv"
  cp config.toml "${_REMOTE_USER_HOME}/.config/direnv/config.toml"
  cp config.toml "${_CONTAINER_USER_HOME}/.config/direnv/config.toml"
}

install_direnv
configure_direnv
