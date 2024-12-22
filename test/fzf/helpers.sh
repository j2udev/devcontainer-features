#!/bin/bash

check_fzf() {
  fzf --version > /dev/null 2>&1
  return $?
}

check_version() {
  fzf --version | grep 0.56.3 > /dev/null 2>&1
  return $?
}
