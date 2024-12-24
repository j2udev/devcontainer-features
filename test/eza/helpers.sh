#!/bin/bash

check_eza() {
  eza --version > /dev/null 2>&1
  return $?
}

check_version() {
  eza --version | grep 0.20.12 > /dev/null 2>&1
  return $?
}

check_theme() {
  stat /home/vscode/.config/eza/theme.yml
  return $?
}
