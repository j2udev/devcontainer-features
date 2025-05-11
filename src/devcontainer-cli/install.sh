#!/bin/bash
set -euo pipefail

install_devcontainers_cli() {
  npm install -g @devcontainers/cli
}

install_devcontainers_cli
