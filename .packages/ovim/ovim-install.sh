#!/usr/bin/env bash

set -e

USER_HOME=$(eval echo ~${SUDO_USER:-$USER})  # changed
OVIM_DIR="$USER_HOME/.local/share/ovim/lvim"  # changed
OVIM_BIN="$USER_HOME/.local/bin/ovim"  # changed
OVIM_CONFIG="$USER_HOME/.config/ovim"  # changed

echo "Installing OVim (LunarVim core + custom config) separately..."

mkdir -p "$OVIM_DIR"
git clone https://github.com/LunarVim/LunarVim.git "$OVIM_DIR" --depth=1

echo "Creating ovim launcher..."
mkdir -p "$(dirname "$OVIM_BIN")"
cat > "$OVIM_BIN" <<EOF
#!/usr/bin/env bash
NVIM_APPNAME=ovim exec lvim "\$@"
EOF

chmod +x "$OVIM_BIN"

echo "Copying default OVim config..."
mkdir -p "$OVIM_CONFIG"
cp -r /etc/skel/.config/lvim/* "$OVIM_CONFIG/"

echo "Installing LunarVim binary (as ovim)..."
make -C "$OVIM_DIR" install PREFIX="$USER_HOME/.local"

echo "Done!"
echo
echo "You can now run OVim using the 'ovim' command."
echo "Make sure '$USER_HOME/.local/bin' is in your PATH."
