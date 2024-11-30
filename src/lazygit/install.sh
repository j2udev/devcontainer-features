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

install_lazygit() {
    local os_arch
    os_arch=$(detect_os_arch)
    local url="https://github.com/jesseduffield/lazygit/releases/download/v${VERSION}/lazygit_${VERSION}_${os_arch}.tar.gz"
    curl -L "$url" | tar xzf - -C /usr/local/bin && chmod +x /usr/local/bin/lazygit
}

configure_lazygit() {
  if [ "$ENABLE_CONFIG" = "true" ]; then
    mkdir -p "$_REMOTE_USER_HOME/.config/lazygit"
    mkdir -p "$_CONTAINER_USER_HOME/.config/lazygit"
    cp config.yml "$_REMOTE_USER_HOME/.config/lazygit/config.yml"
    cp config.yml "$_CONTAINER_USER_HOME/.config/lazygit/config.yml"
  fi
  if [ "$ENABLE_ALIAS" = "true" ]; then
    echo "alias lzg='lazygit'" >> "$_REMOTE_USER_HOME/.bashrc"
    echo "alias lzg='lazygit'" >> "$_REMOTE_USER_HOME/.zshrc"
    echo "alias lzg='lazygit'" >> "$_CONTAINER_USER_HOME/.bashrc"
    echo "alias lzg='lazygit'" >> "$_CONTAINER_USER_HOME/.zshrc"
  fi
}

install_lazygit
configure_lazygit
