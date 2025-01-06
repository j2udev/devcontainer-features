#!/bin/bash

check_shellcheck() {
  shellcheck --version > /dev/null 2>&1
  return $?
}

check_shfmt() {
  shfmt --version > /dev/null 2>&1
  return $?
}
