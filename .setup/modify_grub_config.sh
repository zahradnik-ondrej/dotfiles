#!/bin/bash

modify_grub_config() {

  local template="$HOME/.setup/grub-template.conf"
  local target="/etc/default/grub"

  while IFS='=' read -r key value; do
    [[ "$key" =~ ^#.*$ || -z "$key" ]] && continue
    if grep -q "^$key=" "$target"; then
      sudo sed -i "s|^$key=.*|$key=$value|" "$target"
    else
      echo "$key=$value" | sudo tee -a "$target"
    fi
  done < "$template"

  sudo update-grub

  local scripts=(
    20_linux_xen
    25_bli
    30_uefi-firmware
    35_fwupd
    40_custom
    41_custom
    41_snapshots-btrfs
    60_memtest86+
    60_memtest86+-efi
  )

  for script in "${scripts[@]}"; do
    sudo chmod -x "/etc/grub.d/$script"
  done

}

