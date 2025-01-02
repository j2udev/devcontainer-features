#!/bin/bash

check_kubectl() {
  kubectl version --client > /dev/null 2>&1
  return $?
}

check_version() {
  kubectl version --client | grep 1.31.0 > /dev/null 2>&1
  return $?
}
