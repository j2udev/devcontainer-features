#!/bin/bash
set -euo pipefail

VERSION="${VERSION:-"1.10.3"}"

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

install_terraform() {
  local os_arch=$(detect_os_arch)
  local url="https://releases.hashicorp.com/terraform/${VERSION}/terraform_${VERSION}_${os_arch}.zip"
  curl -L "$url" > /tmp/terraform.zip && unzip -q -o /tmp/terraform.zip -d /usr/local/bin && rm -f /tmp/terraform.zip
}

install_terraform
