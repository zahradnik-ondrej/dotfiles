#!/bin/bash

run() {

  "$@" > /dev/null 2>> "$ERR_FILE"

}
