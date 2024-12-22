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

  echo "${OS}_${ARCH}"
}

install_fzf() {
  local os_arch=$(detect_os_arch)
  local url="https://github.com/junegunn/fzf/releases/download/v${VERSION}/fzf-${VERSION}-${os_arch}.tar.gz"
  curl -L "$url" | sudo tar xzf - -C /usr/local/bin --wildcards 'fzf' && chmod +x /usr/local/bin/fzf
}

configure_fzf() {
  if [ "$ENABLE_CONFIG" = "true" ]; then
    echo "source <(fzf --bash)" >> "$_REMOTE_USER_HOME/.bashrc"
    echo "source <(fzf --zsh)" >> "$_REMOTE_USER_HOME/.zshrc"
    echo "source <(fzf --bash)" >> "$_CONTAINER_USER_HOME/.bashrc"
    echo "source <(fzf --zsh)" >> "$_CONTAINER_USER_HOME/.zshrc"
  fi
}

install_fzf
configure_fzf
