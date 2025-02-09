#!/bin/bash

get_os() {

  if grep -qi "ubuntu" /etc/os-release; then
    echo "ubuntu"
  elif grep -qi "manjaro" /etc/os-release; then
    echo "manjaro"
  else
    echo "unknown"
  fi

}
