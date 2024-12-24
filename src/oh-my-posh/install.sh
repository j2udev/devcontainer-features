#!/bin/bash
set -e

detect_os_arch() {
  OS="$(uname | tr '[:upper:]' '[:lower:]')"
  ARCH="$(uname -m)"

  case $ARCH in
      x86_64) ARCH="amd64" ;;
      armv8*|aarch64) ARCH="arm64" ;;
      armv7*|armhf) ARCH="armv7" ;;
      *) echo "Unsupported architecture: $ARCH"; exit 1 ;;
  esac

  echo "${OS}-${ARCH}"
}

install_oh_my_posh() {
  local os_arch=$(detect_os_arch)
  local url="https://github.com/JanDeDobbeleer/oh-my-posh/releases/download/v${VERSION}/posh-${os_arch}"
  curl -Lo /usr/local/bin/oh-my-posh "$url" && chmod +x /usr/local/bin/oh-my-posh
}

configure_lang() {
  echo "export LC_ALL=en_US.UTF-8" >> "$_REMOTE_USER_HOME/.bashrc"
  echo "export LANG=en_US.UTF-8" >> "$_REMOTE_USER_HOME/.bashrc"
  echo "export LC_ALL=en_US.UTF-8" >> "$_CONTAINER_USER_HOME/.bashrc"
  echo "export LANG=en_US.UTF-8" >> "$_CONTAINER_USER_HOME/.bashrc"
  echo "export LC_ALL=en_US.UTF-8" >> "$_REMOTE_USER_HOME/.zshrc"
  echo "export LANG=en_US.UTF-8" >> "$_REMOTE_USER_HOME/.zshrc"
  echo "export LC_ALL=en_US.UTF-8" >> "$_CONTAINER_USER_HOME/.zshrc"
  echo "export LANG=en_US.UTF-8" >> "$_CONTAINER_USER_HOME/.zshrc"
}

configure_theme() {
  mkdir -p "${_REMOTE_USER_HOME}/.config/oh-my-posh"
  mkdir -p "${_CONTAINER_USER_HOME}/.config/oh-my-posh"
  cp "themes/${THEME}.omp.json" "${_REMOTE_USER_HOME}/.config/oh-my-posh"
  cp "themes/${THEME}.omp.json" "${_CONTAINER_USER_HOME}/.config/oh-my-posh"
  echo "eval \"\$(oh-my-posh init bash -c ${_REMOTE_USER_HOME}/.config/oh-my-posh/${THEME}.omp.json)\"" >> "$_REMOTE_USER_HOME/.bashrc"
  echo "eval \"\$(oh-my-posh init bash -c ${_CONTAINER_USER_HOME}/.config/oh-my-posh/${THEME}.omp.json)\"" >> "$_CONTAINER_USER_HOME/.bashrc"
  echo "eval \"\$(oh-my-posh init zsh -c ${_REMOTE_USER_HOME}/.config/oh-my-posh/${THEME}.omp.json)\"" >> "$_REMOTE_USER_HOME/.zshrc"
  echo "eval \"\$(oh-my-posh init zsh -c ${_CONTAINER_USER_HOME}/.config/oh-my-posh/${THEME}.omp.json)\"" >> "$_CONTAINER_USER_HOME/.zshrc"
}

configure_oh_my_posh() {
  configure_lang
  configure_theme
}

install_oh_my_posh
configure_oh_my_posh
