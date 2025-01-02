#!/bin/bash

check_terragrunt() {
  terragrunt --version > /dev/null 2>&1
  return $?
}

check_version() {
  terragrunt --version | grep 0.71.0 > /dev/null 2>&1
  return $?
}

check_completion() {
  grep "complete -o nospace -C /usr/local/bin/terragrunt terragrunt" /home/vscode/.zshrc > /dev/null 2>&1
  return $?
}
