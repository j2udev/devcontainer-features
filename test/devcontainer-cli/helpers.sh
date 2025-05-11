#!/bin/bash

check_devcontainer_cli() {
  devcontainer --version > /dev/null 2>&1
  return $?
}