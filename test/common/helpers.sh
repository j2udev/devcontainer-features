#!/bin/bash
set +x

check_rc() {
  stat /home/vscode/.config/devcontainer-features/.zshrc
  return $?
}

check_common() {
  cat /home/vscode/.zshrc | grep -F '[[ -f "${XDG_CONFIG_HOME}/devcontainer-features/.zshrc" ]] && "${XDG_CONFIG_HOME}/devcontainer-features/.zshrc"'
  return $?
}
