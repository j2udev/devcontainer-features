#!/bin/bash
set -e

create_rc_files() {
  mkdir -p "${_CONTAINER_USER_HOME}/.config/devcontainer-features"
  mkdir -p "${_REMOTE_USER_HOME}/.config/devcontainer-features"
  touch "${_CONTAINER_USER_HOME}/.config/devcontainer-features/.bashrc"
  touch "${_REMOTE_USER_HOME}/.config/devcontainer-features/.bashrc"
  touch "${_CONTAINER_USER_HOME}/.config/devcontainer-features/.zshrc"
  touch "${_REMOTE_USER_HOME}/.config/devcontainer-features/.zshrc"
}

source_rc_files() {
  echo "### Dev Container Features Configuration ###" >> "${_CONTAINER_USER_HOME}/.${SHELL}rc"
  echo "### Dev Container Features Configuration ###" >> "${_REMOTE_USER_HOME}/.${SHELL}rc"
  echo "XDG_CONFIG_HOME=${_CONTAINER_USER_HOME}/.config" >> "${_CONTAINER_USER_HOME}/.${SHELL}rc"
  echo "XDG_CONFIG_HOME=${_REMOTE_USER_HOME}/.config" >> "${_REMOTE_USER_HOME}/.${SHELL}rc"
  echo "[[ -f \"\${XDG_CONFIG_HOME}/devcontainer-features/.bashrc\" ]] && \"\${XDG_CONFIG_HOME}/devcontainer-features/.bashrc\"" >> "${_CONTAINER_USER_HOME}/.bashrc"
  echo "[[ -f \"\${XDG_CONFIG_HOME}/devcontainer-features/.bashrc\" ]] && \"\${XDG_CONFIG_HOME}/devcontainer-features/.zshrc\"" >> "${_REMOTE_USER_HOME}/.zshrc"
  echo "[[ -f \"\${XDG_CONFIG_HOME}/devcontainer-features/.zshrc\" ]] && \"\${XDG_CONFIG_HOME}/devcontainer-features/.bashrc\"" >> "${_CONTAINER_USER_HOME}/.bashrc"
  echo "[[ -f \"\${XDG_CONFIG_HOME}/devcontainer-features/.zshrc\" ]] && \"\${XDG_CONFIG_HOME}/devcontainer-features/.zshrc\"" >> "${_REMOTE_USER_HOME}/.zshrc"
}

install_common() {
  create_rc_files
  source_rc_files
}

install_common
