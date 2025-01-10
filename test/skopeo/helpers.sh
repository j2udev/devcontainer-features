#!/bin/bash

check_skopeo() {
  skopeo --version > /dev/null 2>&1
  return $?
}
