#!/bin/bash

get_os() {

  if grep -qiE "ubuntu|debian" /etc/os-release; then
    echo "ubuntu"
  elif grep -qi "manjaro" /etc/os-release; then
    echo "manjaro"
  else
    echo "unknown"
  fi

}
