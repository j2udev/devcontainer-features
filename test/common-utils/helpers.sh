#!/bin/bash

check_git() {
  git version > /dev/null 2>&1
  return $?
}

check_ohmyposh() {
  oh-my-posh version > /dev/null 2>&1
  return $?
}

check_eza() {
  eza --version > /dev/null 2>&1
  return $?
}

check_bat() {
  bat --version > /dev/null 2>&1
  return $?
}

check_fzf() {
  fzf --version > /dev/null 2>&1
  return $?
}

check_lazygit() {
  lazygit --version > /dev/null 2>&1
  return $?
}
