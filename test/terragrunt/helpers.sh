#!/bin/bash

check_terragrunt() {
  terragrunt --version > /dev/null 2>&1
  return $?
}

check_version() {
  terragrunt --version | grep 0.71.0 > /dev/null 2>&1
  return $?
}
