#!/bin/bash

check_shfmt() {
  shfmt --version >/dev/null 2>&1
  return $?
}

check_version() {
  shfmt --version | grep 3.9.0 >/dev/null 2>&1
  return $?
}
