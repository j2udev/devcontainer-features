#!/bin/sh
set -x

VERSION="${VERSION:-"0.44.1"}"

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

install_lazygit
