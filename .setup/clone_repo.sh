#!/bin/bash

clone_repo() {

  local repo_url="$1"
  local target_path="$2"

  [ -z "$target_path" ] && target_path=$(basename -s .git "$repo_url")
  [ -e "$target_path" ] && sudo rm -rf "$target_path"
  git clone -q "$repo_url" "$target_path"

}
