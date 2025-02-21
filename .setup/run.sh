#!/bin/bash

run() {
  if [[ -z "$1" ]]; then
    return 1
  fi
  "$@" > /dev/null 2>> "$ERR_FILE"
}
