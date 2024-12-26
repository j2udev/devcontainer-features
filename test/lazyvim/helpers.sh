#!/bin/bash

check_neovim() {
  nvim --version > /dev/null 2>&1
  return $?
}

check_lazyvim() {
  stat /home/vscode/.config/nvim/lazyvim.json
  return $?
}

check_neovim_version() {
  nvim --version | grep "\-dev" > /dev/null 2>&1
  return $?
}
