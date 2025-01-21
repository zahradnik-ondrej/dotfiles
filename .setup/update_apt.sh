#!/bin/bash

update_apt() {

	sudo apt-get update
	sudo apt-get install -f --fix-missing
	sudo apt-get upgrade -y

}
