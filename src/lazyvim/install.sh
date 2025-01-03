#!/bin/bash
set -euo pipefail

NEOVIM_VERSION=${NEOVIM_VERSION:-"stable"}
INSTALL_NEOVIM=${INSTALL_NEOVIM:-"true"}
INSTALL_LAZYVIM=${INSTALL_LAZYVIM:-"true"}
ENABLE_CONFIG=${ENABLE_CONFIG:-"true"}
_REMOTE_USER_HOME=${_REMOTE_USER_HOME:-"/home/node"}
_CONTAINER_USER_HOME=${_CONTAINER_USER_HOME:-"/home/node"}

install_debian_dependencies() {
  apt-get update -y
  apt-get -y install ninja-build gettext cmake unzip curl build-essential
  apt-get -y clean
  rm -rf /var/lib/apt/lists/*
}

install_neovim() {
  if [ "$NEOVIM_VERSION" = "stable" ] || [ "$NEOVIM_VERSION" = "nightly" ]; then
    curl -sL https://github.com/neovim/neovim/archive/refs/tags/${NEOVIM_VERSION}.tar.gz | tar -xzC /tmp 2>&1
  else
    curl -sL https://github.com/neovim/neovim/archive/refs/tags/v${NEOVIM_VERSION}.tar.gz | tar -xzC /tmp 2>&1
  fi
  cd /tmp/neovim-${NEOVIM_VERSION}
  make && make CMAKE_INSTALL_PREFIX=/usr/local/nvim install
  ln -sf /usr/local/nvim/bin/nvim /usr/local/bin/nvim
  cd -
  rm -rf /tmp/neovim-${NEOVIM_VERSION}
}

install_lazyvim() {
  rm -rf ${_REMOTE_USER_HOME}/.config/nvim
  git clone https://github.com/LazyVim/starter "${_REMOTE_USER_HOME}/.config/nvim"
  rm -rf "${_REMOTE_USER_HOME}/.config/nvim/.git"
  chown -R "$_REMOTE_USER" "${_REMOTE_USER_HOME}/.config/nvim"
  if [ "$_REMOTE_USER_HOME" != "$_CONTAINER_USER_HOME" ]; then
    rm -rf ${_CONTAINER_USER_HOME}/.config/nvim
    git clone https://github.com/LazyVim/starter "${_CONTAINER_USER_HOME}/.config/nvim"
    rm -rf "${_CONTAINER_USER_HOME}/.config/nvim/.git"
    chown -R "$_CONTAINER_USER" "${_CONTAINER_USER_HOME}/.config/nvim"
  fi
}

configure_lazyvim() {
  cp config/* "${_REMOTE_USER_HOME}/.config/nvim/lua/config"
  cp config/* "${_CONTAINER_USER_HOME}/.config/nvim/lua/config"
  cp plugins/* "${_REMOTE_USER_HOME}/.config/nvim/lua/plugins"
  cp plugins/* "${_CONTAINER_USER_HOME}/.config/nvim/lua/plugins"
}

if [ "$INSTALL_NEOVIM" = "true" ]; then
  install_debian_dependencies
  install_neovim
fi
if [ "$INSTALL_LAZYVIM" = "true" ]; then
  install_lazyvim
fi
if [ "$INSTALL_LAZYVIM" = "true" ] && [ "$ENABLE_CONFIG" = "true" ]; then
  configure_lazyvim
fi
