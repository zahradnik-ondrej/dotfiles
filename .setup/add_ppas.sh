#!/bin/bash

add_ppas() {

  while IFS= read -r repo; do
    printf "$repo"
    check bash -c "grep -rh \"^deb .*$(echo $repo | awk '{print $NF}')\" /etc/apt/sources.list /etc/apt/sources.list.d/ >/dev/null || sudo add-apt-repository -y '$repo'"
  done < "${HOME}/.setup/apt-repositories.txt"

}
