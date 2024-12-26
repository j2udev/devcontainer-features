#!/bin/sh
set -e

VERSION=${VERSION:-stable}
INSTALL_NEOVIM=${INSTALL_NEOVIM:-"true"}
ENABLE_CONFIG=${ENABLE_CONFIG:-"true"}

# Debian / Ubuntu dependencies
install_debian_dependencies() {
  echo "### Installing Neovim dependencies ###"

  apt-get update -y
  apt-get -y install ninja-build gettext cmake unzip curl build-essential

  apt-get -y clean
  rm -rf /var/lib/apt/lists/*
}

install_neovim() {
  echo "### Installing Neovim ###"

  curl -sL https://github.com/neovim/neovim/archive/refs/tags/${VERSION}.tar.gz | tar -xzC /tmp 2>&1

  cd /tmp/neovim-${VERSION}

  make && make CMAKE_INSTALL_PREFIX=/usr/local/nvim install
  ln -sf /usr/local/nvim/bin/nvim /usr/local/bin/nvim

  rm -rf /tmp/neovim-${VERSION}
}

install_lazyvim() {
  echo "### Installing LazyVim ###"

  git clone https://github.com/LazyVim/starter "${_REMOTE_USER_HOME}/.config/nvim"
  git clone https://github.com/LazyVim/starter "${_CONTAINER_USER_HOME}/.config/nvim"
  rm -rf "${_REMOTE_USER_HOME}/.config/nvim/.git"
  rm -rf "${_CONTAINER_USER_HOME}/.config/nvim/.git"
}

configure_lazyvim() {
  cp config/* "${_REMOTE_USER_HOME}/.config/nvim/lua/config"
  cp config/* "${_CONTAINER_USER_HOME}/.config/nvim/lua/config"
}

if [ "$INSTALL_NEOVIM" = "true" ]; then
  install_debian_dependencies
  install_neovim
fi
install_lazyvim
if [ "$ENABLE_CONFIG" = "true" ]; then
  configure_lazyvim
fi
