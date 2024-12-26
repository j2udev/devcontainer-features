#!/bin/bash

check_bat() {
  bat --version > /dev/null 2>&1
  return $?
}

check_version() {
  bat --version | grep 0.23.0 > /dev/null 2>&1
  return $?
}

check_theme() {
  grep "bat --theme=Nord" /home/vscode/.zshrc
  return $?
}
