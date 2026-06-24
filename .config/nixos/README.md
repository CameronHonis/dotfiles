# NixOS Configurations

## Machines

- **rook** - Desktop machine (systemd-boot, NVIDIA)
- **mercury** - Laptop (GRUB, dual-boot with Windows)

## Installing mercury (fresh install)

1. Boot into NixOS installer

2. Generate hardware config:
   ```bash
   sudo nixos-generate-config --show-hardware-config > /mnt/etc/nixos/mercury-hardware-configuration.nix
   ```

3. Clone this repo to `/mnt/etc/nixos`:
   ```bash
   sudo git clone <repo-url> /mnt/etc/nixos
   ```

4. Copy the hardware config:
   ```bash
   sudo cp /mnt/etc/nixos/mercury-hardware-configuration.nix /mnt/etc/nixos/
   ```

5. Install:
   ```bash
   sudo nixos-install --flake /mnt/etc/nixos#mercury
   ```

6. Reboot

## Rebuilding

```bash
sudo nixos-rebuild switch --flake .#rook
sudo nixos-rebuild switch --flake .#mercury
```
