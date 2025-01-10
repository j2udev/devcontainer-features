#!/bin/bash
set -euo pipefail

REGISTRY_AUTH_FILE="${REGISTRY_AUTH_FILE:-'${HOME}/.docker/config.json'}"

VERSION="${VERSION:-"1.8.8"}"

configure_skopeo() {
  echo "export REGISTRY_AUTH_FILE=${REGISTRY_AUTH_FILE}" >> "$1"
}

install_skopeo() {
  apt update && apt install -y skopeo
  configure_skopeo "${_REMOTE_USER_HOME}/.zshrc"
  configure_skopeo "${_CONTAINER_USER_HOME}/.zshrc"
  configure_skopeo "${_REMOTE_USER_HOME}/.bashrc"
  configure_skopeo "${_CONTAINER_USER_HOME}/.bashrc"
}

install_skopeo
