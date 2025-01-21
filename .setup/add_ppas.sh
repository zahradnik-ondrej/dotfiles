#!/bin/bash

add_ppas() {

  # multiverse
  printf "multiverse"
  check sudo add-apt-repository -y multiverse

  # papirus
  printf "papirus"
  check sudo add-apt-repository -y ppa:papirus/papirus

	if [ "$dev_env" -eq 1 ]; then

		# love2d
		printf "love2d"
		check sudo add-apt-repository -y ppa:bartbes/love-stable

	fi

	if [ "$three_d" -eq 1 ]; then

		# freecad
		printf "freecad"
		check sudo add-apt-repository -y ppa:freecad-maintainers/freecad-stable

	fi

	if [ "$utilities" -eq 1 ]; then

		# obs
		printf "obs"
		check sudo add-apt-repository -y ppa:obsproject/obs-studio

		# peek
		printf "peek"
		check sudo add-apt-repository -y ppa:peek-developers/stable

	fi

	if [ "$misc" -eq 1 ]; then

		# kicad
		printf "kicad"
		check sudo add-apt-repository -y ppa:kicad/kicad-8.0-releases

	fi

}
