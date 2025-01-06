#!/bin/bash

check_shellcheck() {
  shellcheck --version > /dev/null 2>&1
  return $?
}

check_version() {
  shellcheck --version | grep 0.9.0 > /dev/null 2>&1
  return $?
}
