#!/bin/bash

check_direnv() {
  direnv version > /dev/null 2>&1
  return $?
}

check_version() {
  direnv version | grep 2.34.0 > /dev/null 2>&1
  return $?
}