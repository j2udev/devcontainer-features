#!/bin/bash

check_zarf() {
  zarf version > /dev/null 2>&1
  return $?
}

check_version() {
  zarf version | grep 0.44.0 > /dev/null 2>&1
  return $?
}
