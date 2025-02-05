#!/bin/bash
set -euo pipefail

BIN_DIR="${BIN_DIR:-"/usr/local/bin"}"
VERSION="${VERSION:-"0.20.13"}"
THEME="${THEME:-"tokyonight"}"
ENABLE_ALIAS="${ENABLE_ALIAS:-"true"}"
ENABLE_ICONS="${ENABLE_ICONS:-"false"}"
_REMOTE_USER_HOME="${_REMOTE_USER_HOME:-"/home/vscode"}"
_CONTAINER_USER_HOME="${_CONTAINER_USER_HOME:-"/home/vscode"}"

shells=("zsh" "bash")
homes=("${_REMOTE_USER_HOME}" "${_CONTAINER_USER_HOME}")

get_os() {
  local os
  os="$(uname | tr '[:upper:]' '[:lower:]')"
  echo "${os}"
}

get_arch() {
  local arch
  arch="$(uname -m)"
  case "${arch}" in
  x86_64) arch="x86_64" ;;
  aarch64) arch="aarch64" ;;
  *)
    echo "Unsupported architecture: ${arch}"
    exit 1
    ;;
  esac
  echo "${arch}"
}

install_eza() {
  local url
  url="https://github.com/eza-community/eza/releases/download/v${VERSION}/eza_$(get_arch)-unknown-$(get_os)-gnu.tar.gz"
  curl -L "${url}" | tar xzf - -C "${BIN_DIR}" && chmod +x "${BIN_DIR}/eza"
}

configure_eza() {
  for shell in "${shells[@]}"; do
    for home in "${homes[@]}"; do
      mkdir -p "${home}/.config/eza"
      cp "themes/${THEME}.yml" "${home}/.config/eza/theme.yml"
      if [ "$ENABLE_ALIAS" = "true" ]; then
        if [ "$ENABLE_ICONS" = "true" ]; then
          echo "alias ls='eza --icons'" >>"${home}/.${shell}rc"
          echo "alias l='eza -lah --icons'" >>"${home}/.${shell}rc"
        else
          echo "alias ls='eza'" >>"${home}/.${shell}rc"
          echo "alias l='eza -lah'" >>"${home}/.${shell}rc"
        fi
      fi
    done
  done
}

install_eza
configure_eza
