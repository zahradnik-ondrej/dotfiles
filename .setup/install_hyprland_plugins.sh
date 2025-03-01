#!/bin/bash

install_hyprland_plugins() {

  hyprpm add https://github.com/hyprwm/hyprland-plugins
  hyprpm enable hyprbars

  hyprpm add https://github.com/virtcode/hypr-dynamic-cursors
  hyprpm enable dynamic-cursors

}

