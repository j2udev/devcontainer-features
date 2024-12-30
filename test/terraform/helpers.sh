#!/bin/bash

check_terraform() {
  terraform --version > /dev/null 2>&1
  return $?
}

check_version() {
  terraform --version | grep 1.10.2 > /dev/null 2>&1
  return $?
}
