#!/bin/bash

check_helm() {
  helm version > /dev/null 2>&1
  return $?
}

check_version() {
  helm version | grep 3.16.3 > /dev/null 2>&1
  return $?
}
