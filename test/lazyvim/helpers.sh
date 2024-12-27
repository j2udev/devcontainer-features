#!/bin/bash

check_neovim() {
  nvim --version > /dev/null 2>&1
  return $?
}

check_lazyvim() {
  stat /home/vscode/.config/nvim/lua/config/keymaps.lua
  return $?
}

check_neovim_version() {
  nvim --version | grep "0.10.2" > /dev/null 2>&1
  return $?
}
