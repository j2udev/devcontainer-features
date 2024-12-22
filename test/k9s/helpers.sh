#!/bin/bash

check_k9s() {
  k9s version > /dev/null 2>&1
  return $?
}

check_version() {
  k9s version | grep 0.31.9 > /dev/null 2>&1
  return $?
}

check_config() {
  stat "/home/vscode/.config/k9s/config.yaml" > /dev/null 2>&1
  return $?
}

check_skins() {
  stat "/home/vscode/.config/k9s/skins/transparent.yaml" > /dev/null 2>&1
  return $?
}
