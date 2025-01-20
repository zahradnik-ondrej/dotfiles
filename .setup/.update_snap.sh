#!/bin/bash

update_snap() {
	if ! snap list | grep -q core; then
    sudo snap install core
	fi
	sudo snap refresh
}
