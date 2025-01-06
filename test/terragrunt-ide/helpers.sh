#!/bin/bash

check_opentofu() {
  tofu --version > /dev/null 2>&1
  return $?
}

check_terragrunt() {
  terragrunt --version > /dev/null 2>&1
  return $?
}
