#!/bin/bash
set -x

VERSION="${VERSION:-"1.8.8"}"

detect_os_arch() {
  OS="$(uname | tr '[:upper:]' '[:lower:]')"
  ARCH="$(uname -m)"

  case $ARCH in
      x86_64) ARCH="amd64" ;;
      armv8*|aarch64) ARCH="arm64" ;;
      *) echo "Unsupported architecture: $ARCH"; exit 1 ;;
  esac

  echo "${OS}_${ARCH}"
}

install_opentofu() {
  local os_arch=$(detect_os_arch)
  local url="https://github.com/opentofu/opentofu/releases/download/v${VERSION}/tofu_${VERSION}_${os_arch}.tar.gz"
  curl -L "$url" | tar xzf - -C /usr/local/bin
}

install_completions() {
  tofu -install-autocomplete
}

install_opentofu
