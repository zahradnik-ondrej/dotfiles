#!/bin/bash

run() {
	"$@" >/dev/null 2>&1
	local exit_code=$?

	if [ $exit_code -eq 0 ]; then
		printf "${green} ✓${reset}\n"
    return 1
	else
		printf "${red} ✗${reset}\n"
    return 0
	fi
}
