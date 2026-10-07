install_snap() {

  sudo rm -f /var/lib/pacman/db.lck
  sudo pacman -S --needed --noconfirm snapd
  sudo systemctl enable --now snapd
  sudo systemctl restart snapd
  sudo ln -s /var/lib/snapd/snap /snap
  sudo systemctl enable --now snapd.apparmor

  sudo snap install core
  sudo snap refresh

}
