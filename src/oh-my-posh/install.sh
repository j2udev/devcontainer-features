#!/bin/bash
set -euo pipefail

BIN_DIR="${BIN_DIR:-"/usr/local/bin"}"
VERSION="${VERSION:-"0.26.0"}"
THEME="${THEME:-"j2udev"}"
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
  x86_64) arch="amd64" ;;
  aarch64) arch="arm64" ;;
  *)
    echo "Unsupported architecture: ${arch}"
    exit 1
    ;;
  esac
  echo "${arch}"
}

install_ohmyposh() {
  local url
  url="https://github.com/JanDeDobbeleer/oh-my-posh/releases/download/v${VERSION}/posh-$(get_os)-$(get_arch)"
  curl -Lo "${BIN_DIR}/oh-my-posh" "${url}" && chmod +x "${BIN_DIR}/oh-my-posh"
}

configure_ohmyposh() {
  for shell in "${shells[@]}"; do
    for home in "${homes[@]}"; do
      mkdir -p "${home}/.config/oh-my-posh"
      cp "themes/${THEME}.omp.json" "${home}/.config/oh-my-posh"
      echo "export LC_ALL=en_US.UTF-8" >> "${home}/.${shell}rc"
      echo "export LANG=en_US.UTF-8" >> "${home}/.${shell}rc"
      echo "eval \"\$(oh-my-posh init ${shell} -c ${home}/.config/oh-my-posh/${THEME}.omp.json)\"" >> "${home}/.${shell}rc"
    done
  done
}

install_ohmyposh
configure_ohmyposh
