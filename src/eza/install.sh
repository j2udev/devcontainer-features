#!/bin/bash
set -euo pipefail

VERSION="${VERSION:-"0.20.13"}"
THEME="${THEME:-"tokyonight"}"

install_eza() {
  local os="$(uname | tr '[:upper:]' '[:lower:]')"
  local arch="$(uname -m)"
  local url="https://github.com/eza-community/eza/releases/download/v${VERSION}/eza_${arch}-unknown-${os}-gnu.tar.gz"
  curl -L "$url" | tar xzf - -C /usr/local/bin && chmod +x /usr/local/bin/eza
}

configure_eza() {
  mkdir -p "${_REMOTE_USER_HOME}/.config/eza"
  mkdir -p "${_CONTAINER_USER_HOME}/.config/eza"
  cp "themes/${THEME}.yml" "${_REMOTE_USER_HOME}/.config/eza/theme.yml"
  cp "themes/${THEME}.yml" "${_CONTAINER_USER_HOME}/.config/eza/theme.yml"
  if [ "$ENABLE_ALIAS" = "true" ]; then
    echo "alias ls='eza --icons'" >> "${_REMOTE_USER_HOME}/.bashrc"
    echo "alias ls='eza --icons'" >> "${_CONTAINER_USER_HOME}/.bashrc"
    echo "alias ls='eza --icons'" >> "${_REMOTE_USER_HOME}/.zshrc"
    echo "alias ls='eza --icons'" >> "${_CONTAINER_USER_HOME}/.zshrc"
  fi
}

install_eza
configure_eza
