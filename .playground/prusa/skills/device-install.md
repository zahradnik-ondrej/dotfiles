## Device Install Workflow

### 7. Transfer Image to Device
- Ask the user for the target device IP address and wait for their response
- Use `scp` to transfer the `.dev-key.raucb` file from `~/.playground/prusa/images/` to `root@<ip_address>:/tmp/`

### 8. Install Image
- SSH into `root@<ip_address>`
- Run `/usr/sbin/set-update-channel.sh dev`
- Run `rauc install /tmp/<image_filename>.dev-key.raucb`

### 9. Reboot
- While still in the SSH session on the remote device, run `reboot`
