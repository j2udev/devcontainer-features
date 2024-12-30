#!/bin/bash

check_ansible() {
  ansible --version > /dev/null 2>&1
  return $?
}

check_version() {
  ansible --version | grep "core 2.17" > /dev/null 2>&1
  return $?
}
