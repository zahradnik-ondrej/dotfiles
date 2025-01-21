#!/bin/bash

ask_install() {

	local name=$1
	local default=${2:-yes}

	local name_upper=$(echo "$name" | tr '[:lower:]' '[:upper:]')

	local options

	if [[ "$default" =~ ^[Yy] ]]; then

		options="[${green}Y${cyan}/n${cyan}]"

	else

		options="[${cyan}y/${red}N${cyan}]"

	fi

	while true; do

		read -p "$(echo -e "${cyan}Do you want to install packages in the ${bold}$name_upper${reset_bold} category? $options${cyan}: ${reset}")" answer

		if [[ -z "$answer" ]]; then

			answer=$default

		fi

		case $answer in

			[Yy]* ) return 1 ;;
			[Nn]* ) return 0 ;;
			* ) echo "Please answer yes or no." ;;

		esac

	done

}

