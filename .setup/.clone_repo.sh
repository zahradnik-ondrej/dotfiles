#!/bin/bash

clone_repo() {
	local repo_url="$1"
	local target_path="$2"

	if [ -z "$target_path" ]; then
    target_path=$(basename -s .git "$repo_url")
  fi

  [ -e "$target_path" ] && rm -rf "$target_path"
  sudo git clone -q "$repo_url" "$target_path"
}
