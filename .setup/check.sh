#!/bin/bash

check() {

  run "$@"
  local exit_code=$?

  if [ $exit_code -eq 0 ]; then

    printf "${green} ✓${reset}\n"
    [ -f "$ERR_FILE" ] && rm "$ERR_FILE"
    return 1

  else

    printf "${red} ✗${reset}\n"

    if [[ -f "$ERR_FILE" && -s "$ERR_FILE" ]]; then

      printf "${red}"
      cat "$ERR_FILE"
      printf "${reset}"

      rm "$ERR_FILE"

    fi

    return 0

  fi

}
