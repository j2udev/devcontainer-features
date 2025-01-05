#!/bin/bash
set -euo pipefail

BIN_DIR="${BIN_DIR:-"/usr/local/bin"}"
VERSION="${VERSION:-"2.35.0"}"
_REMOTE_USER_HOME="${_REMOTE_USER_HOME:-"/home/vscode"}"
_CONTAINER_USER_HOME="${_CONTAINER_USER_HOME:-"/home/vscode"}"

get_os() {
  local os="$(uname | tr '[:upper:]' '[:lower:]')"
  echo "${os}"
}

get_arch() {
  local arch="$(uname -m)"
  case "$arch" in
      x86_64) arch="amd64" ;;
      aarch64) arch="arm64" ;;
      *) echo "Unsupported architecture: ${arch}"; exit 1 ;;
  esac
  echo "${arch}"
}

copy_config() {
  mkdir -p "${1}/.config/direnv"
  cp config.toml "${1}/.config/direnv/config.toml"
}

configure_shell() {
  echo "eval \"\$(direnv hook ${1})\"" >> "${2}/.${1}rc"
}

configure_direnv() {
  copy_config "$_REMOTE_USER_HOME"
  copy_config "$_CONTAINER_USER_HOME"
  configure_shell zsh "$_REMOTE_USER_HOME"
  configure_shell zsh "$_CONTAINER_USER_HOME"
  configure_shell bash "$_REMOTE_USER_HOME"
  configure_shell bash "$_CONTAINER_USER_HOME"
}


install_direnv() {
  local url="https://github.com/direnv/direnv/releases/download/v${VERSION}/direnv.$(get_os)-$(get_arch)"
  curl -Lo "${BIN_DIR}/direnv" "$url" && chmod +x "${BIN_DIR}/direnv"
}

install_direnv
configure_direnv
