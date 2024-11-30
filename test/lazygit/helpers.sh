#!/bin/bash

check_lazygit() {
  lazygit --version > /dev/null 2>&1
  return $?
}

check_version() {
  lazygit --version | grep 0.44.0 > /dev/null 2>&1
  return $?
}

check_config() {
  stat "/home/vscode/.config/lazygit/config.yml" > /dev/null 2>&1
  return $?
}

check_alias() {
  source /home/vscode/.zshrc > /dev/null 2>&1
  source /home/vscode/.bashrc  > /dev/null 2>&1
  alias lzg  > /dev/null 2>&1
  return $?
}