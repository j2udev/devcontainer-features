#!/bin/bash
# set -e
set -x

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

install_k9s() {
  local os_arch=$(detect_os_arch)
  local url="https://github.com/derailed/k9s/releases/download/v${VERSION}/k9s_${os_arch}.tar.gz"
  curl -L "$url" | sudo tar xzf - -C /usr/local/bin --wildcards 'k9s' && chmod +x /usr/local/bin/k9s
}

configure_k9s() {
  if [ "$ENABLE_CONFIG" = "true" ]; then
    mkdir -p "$_REMOTE_USER_HOME/.config/k9s/skins"
    mkdir -p "$_CONTAINER_USER_HOME/.config/k9s/skins"
    cp config.yaml "$_REMOTE_USER_HOME/.config/k9s/config.yaml"
    cp config.yaml "$_CONTAINER_USER_HOME/.config/k9s/config.yaml"
    cp skins/* "$_REMOTE_USER_HOME/.config/k9s/skins"
    cp skins/* "$_CONTAINER_USER_HOME/.config/k9s/skins"
  fi
}

install_k9s
configure_k9s
