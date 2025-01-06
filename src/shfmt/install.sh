#!/bin/bash
set -euo pipefail

VERSION="${VERSION:-"3.10.0"}"
BIN_DIR="${BIN_DIR:-"/usr/local/bin"}"
_REMOTE_USER_HOME="${_REMOTE_USER_HOME:-"/home/vscode"}"
_CONTAINER_USER_HOME="${_CONTAINER_USER_HOME:-"/home/vscode"}"

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

install_shfmt() {
  local url
  url="https://github.com/mvdan/sh/releases/download/v${VERSION}/shfmt_v${VERSION}_$(get_os)_$(get_arch)"
  curl -Lo "${BIN_DIR}/shfmt" "${url}" &&
    chmod +x "${BIN_DIR}/shfmt"
}

install_shfmt
