#!/bin/bash

check_oh_my_posh() {
  oh-my-posh --version > /dev/null 2>&1
  return $?
}

check_version() {
  oh-my-posh --version | grep 24.17.0 > /dev/null 2>&1
  return $?
}
