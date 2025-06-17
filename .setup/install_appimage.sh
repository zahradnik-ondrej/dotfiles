#!/bin/bash

install_appimage() {

  local expected_version="$1"
  local download_url="$2"
  local appimage_path="$3"
  local appimage_file="$4"

  local current_version="none"

  if [ -n "$expected_version" ]; then
    [ -f "$appimage_path/$appimage_file" ] && current_version=$("$appimage_path/$appimage_file" --appimage-version 2>/dev/null)
  fi

  if [ -z "$expected_version" ] || [ "$current_version" != "$expected_version" ]; then

    sudo mkdir -p "$appimage_path"
    run sudo wget -O "$appimage_path/$appimage_file" "$download_url"
    sudo chmod +x "$appimage_path/$appimage_file"

  fi

  check test -f "$appimage_path/$appimage_file"

}
