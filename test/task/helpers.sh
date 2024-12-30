#!/bin/bash

check_task() {
  task --version > /dev/null 2>&1
  return $?
}

check_version() {
  task --version | grep 3.40.0 > /dev/null 2>&1
  return $?
}
