install_packages() {
  PACKAGE_FILE="${HOME}/.setup/packages.json"

  sudo pacman -S --needed --noconfirm jq npm python-pipx
  npm config set prefix "$HOME/.local"

  while read -r pkg; do
    name=$(echo "$pkg" | jq -r '.name // empty')
    manager=$(echo "$pkg" | jq -r '.manager // empty')
    version=$(echo "$pkg" | jq -r '.version // empty')
    display_name=$(echo "$pkg" | jq -r '.display_name // empty')

    if [[ -z "$name" || -z "$manager" ]]; then
      echo "Skipping package due to missing name or manager: $pkg"
      continue
    fi

    case "$manager" in
      yay|npm|pipx)
        ;;
      *)
        echo "Skipping '$name': unknown package manager '$manager'"
        continue
        ;;
    esac

    [[ -z "$display_name" ]] && display_name="$name"

    printf "$display_name"

    case "$manager" in
      yay)
        status bash -c "pacman -Qi '$name' >/dev/null || yay -S --noconfirm '$name'"
        ;;
      npm)
        status bash -c "npm ls -g '$name' >/dev/null || npm install -g '$name'"
        ;;
      pipx)
        status bash -c "pipx list --short | grep -q '^$name ' || pipx install --quiet '$name'"
        ;;
    esac
  done < <(jq -c '.[]' "$PACKAGE_FILE")
}
