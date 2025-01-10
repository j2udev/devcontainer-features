#!/bin/bash

check_skopeo() {
  skopeo --version > /dev/null 2>&1
  return $?
}

check_registry_auth() {
  source /home/vscode/.bashrc
  env | grep "REGISTRY_AUTH_FILE=/root/.docker/config.json"
}
