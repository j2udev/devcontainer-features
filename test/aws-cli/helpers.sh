#!/bin/bash

check_aws_cli() {
  aws --version > /dev/null 2>&1
  return $?
}

check_completion() {
  grep "complete -C aws_completer aws" "/home/vscode/.zshrc" > /dev/null 2>&1
  return $?
}
