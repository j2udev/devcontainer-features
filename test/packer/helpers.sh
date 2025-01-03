#!/bin/bash

check_packer() {
  packer version > /dev/null 2>&1
  return $?
}

check_version() {
  packer version | grep 1.11.1 > /dev/null 2>&1
  return $?
}

check_completion() {
  grep "complete -o nospace -C /usr/local/bin/packer packer" /home/vscode/.zshrc > /dev/null 2>&1
  return $?
}
