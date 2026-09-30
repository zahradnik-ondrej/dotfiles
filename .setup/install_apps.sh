install_apps() {

  # grub2-themes
  GRUB2_THEMES_PATH="$HOME/.grub2-themes"
  clone_repo "https://github.com/vinceliuice/grub2-themes.git" "$GRUB2_THEMES_PATH"

  # lunarvim
  printf "lunarvim"
  if ! command -v lvim &> /dev/null; then
    LV_BRANCH='release-1.4/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.4/neovim-0.9/utils/installer/install.sh) <<< $'n\nn\nn'
    echo
  fi
  status command -v lvim

  # tpm
  printf "tpm"
  clone_repo "https://github.com/tmux-plugins/tpm" "$HOME/.tmux/plugins/tpm"
  status test -d "$HOME/.tmux/plugins/tpm"

  # vim-tmux-cycle
  printf "vim-tmux-cycle"
  VIM_TMUX_CYCLE_REPO_PATH="$HOME/.vim-tmux-cycle"
  VIM_TMUX_CYCLE_BIN_PATH="/usr/local/bin"
  clone_repo "https://github.com/slarwise/vim-tmux-cycle" "$VIM_TMUX_CYCLE_REPO_PATH"
  sudo mv "$VIM_TMUX_CYCLE_REPO_PATH/vim-tmux-cycle" "$VIM_TMUX_CYCLE_BIN_PATH"
  chmod +x "$VIM_TMUX_CYCLE_BIN_PATH/vim-tmux-cycle"
  status test -x "$VIM_TMUX_CYCLE_BIN_PATH/vim-tmux-cycle"

  if [ "$os" = "manjaro" ]; then

    if command -v hyprpm &>/dev/null && [[ -n "$HYPRLAND_INSTANCE_SIGNATURE" ]]; then

      hyprpm update

      printf "hyprbars"
      if ! hyprpm list | grep -q hyprbars; then
        yes | hyprpm add https://github.com/hyprwm/hyprland-plugins
      fi
      status hyprpm enable hyprbars

      printf "hypr-dynamic-cursors"
      if ! hyprpm list | grep -q dynamic-cursors; then
        yes | hyprpm add https://github.com/virtcode/hypr-dynamic-cursors
      fi
      status hyprpm enable dynamic-cursors

    fi

  fi

}
