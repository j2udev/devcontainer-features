#!/bin/bash

check_opentofu() {
  tofu --version > /dev/null 2>&1
  return $?
}

check_version() {
  tofu --version | grep 1.8.7 > /dev/null 2>&1
  return $?
}

check_completion() {
  grep "complete -o nospace -C /usr/local/bin/tofu tofu" /home/vscode/.zshrc > /dev/null 2>&1
  return $?
}
