#!/bin/bash

cleanup() {

	sudo apt-get autoclean >/dev/null
	sudo apt-get autoremove -y >/dev/null

}
