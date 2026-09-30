clone_repo() {

  local repo_url="$1"
  local target_path="$2"

  [ -z "$target_path" ] && target_path=$(basename -s .git "$repo_url")
  if [ -e "$target_path" ]; then
    if [ -w "$target_path" ]; then
      rm -rf "$target_path"
    else
      sudo rm -rf "$target_path"
    fi
  fi
  git clone -q "$repo_url" "$target_path"

}
