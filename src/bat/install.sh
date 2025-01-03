#!/bin/bash
set -euo pipefail

VERSION="${VERSION:-"0.24.0"}"
THEME="${THEME:-"default"}"

install_bat() {
  local os="$(uname | tr '[:upper:]' '[:lower:]')"
  local arch="$(uname -m)"
  local url="https://github.com/sharkdp/bat/releases/download/v${VERSION}/bat-v${VERSION}-${arch}-unknown-${os}-gnu.tar.gz"
  curl -L "$url" | tar xzf - -C /opt && ln -s /opt/bat-v${VERSION}-${arch}-unknown-${os}-gnu/bat /usr/local/bin/bat
}

configure_bat() {
  echo "alias bat='bat --theme=${THEME}'" >> "${_REMOTE_USER_HOME}/.bashrc"
  echo "alias bat='bat --theme=${THEME}'" >> "${_CONTAINER_USER_HOME}/.bashrc"
  echo "alias cat='bat -Pp --theme=${THEME}'" >> "${_REMOTE_USER_HOME}/.bashrc"
  echo "alias cat='bat -Pp --theme=${THEME}'" >> "${_CONTAINER_USER_HOME}/.bashrc"
  echo "alias bat='bat --theme=${THEME}'" >> "${_REMOTE_USER_HOME}/.zshrc"
  echo "alias bat='bat --theme=${THEME}'" >> "${_CONTAINER_USER_HOME}/.zshrc"
  echo "alias cat='bat -Pp --theme=${THEME}'" >> "${_REMOTE_USER_HOME}/.zshrc"
  echo "alias cat='bat -Pp --theme=${THEME}'" >> "${_CONTAINER_USER_HOME}/.zshrc"
}

install_bat
configure_bat
