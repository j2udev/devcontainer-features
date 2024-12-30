#!/bin/bash
set -x

VERSION="${VERSION:-"0.32.7"}"
ENABLE_CONFIG="${ENABLE_CONFIG:-"true"}"
THEME="${THEME:-"transparent"}"
_REMOTE_USER_HOME="${_REMOTE_USER_HOME:-"/home/vscode"}"
_CONTAINER_USER_HOME="${_CONTAINER_USER_HOME:-"/home/vscode"}"

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

write_config() {
  cat <<EOF > "${1}/.config/k9s/config.yaml"
k9s:
  ui:
    skin: "${THEME}.yaml"
EOF
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
    cp themes/* "$_REMOTE_USER_HOME/.config/k9s/skins"
    cp themes/* "$_CONTAINER_USER_HOME/.config/k9s/skins"
    write_config "$_REMOTE_USER_HOME"
    write_config "$_CONTAINER_USER_HOME"
  fi
}

install_k9s
configure_k9s
