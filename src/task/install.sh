#!/bin/bash
set -euo pipefail

VERSION="${VERSION:-"3.40.1"}"

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

install_task() {
  local os_arch=$(detect_os_arch)
  local url="https://github.com/go-task/task/releases/download/v${VERSION}/task_${os_arch}.tar.gz"
  curl -L "$url" | tar xzf - -C /usr/local/bin --wildcards 'task'
}

install_task
