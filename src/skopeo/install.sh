#!/bin/bash
set -euo pipefail

_REMOTE_USER_HOME="${_REMOTE_USER_HOME:-"/home/vscode"}"
_CONTAINER_USER_HOME="${_CONTAINER_USER_HOME:-"/home/vscode"}"

configure_skopeo() {
  mkdir -p "${1}/.config/containers"
  jq -r '.credsStore' "${1}/.docker/config.json" | xargs -I{} echo 'credential-helpers = ["{}"]' > "${1}/.config/containers/registries.conf"
}

install_skopeo() {
  apt update && apt install -y skopeo
  configure_skopeo "${_REMOTE_USER_HOME}"
  configure_skopeo "${_CONTAINER_USER_HOME}"
  configure_skopeo "${_REMOTE_USER_HOME}"
  configure_skopeo "${_CONTAINER_USER_HOME}"
}

install_skopeo
