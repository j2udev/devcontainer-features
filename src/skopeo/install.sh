#!/bin/bash
set -euo pipefail

install_skopeo() {
  apt update && apt install -y skopeo
}

install_skopeo
