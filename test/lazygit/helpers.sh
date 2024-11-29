#!/bin/bash

check_config() {
  stat "/home/vscode/.config/lazygit/config.yml"
  return $?
}