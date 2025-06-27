#!/usr/bin/env bash
set -e

# Install required packages
if command -v pacman >/dev/null 2>&1; then
    sudo pacman -S --needed grub efibootmgr os-prober
elif command -v apt-get >/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y grub efibootmgr os-prober
elif command -v dnf >/dev/null 2>&1; then
    sudo dnf install -y grub efibootmgr os-prober
elif command -v zypper >/dev/null 2>&1; then
    sudo zypper install -y grub efibootmgr os-prober
else
    echo "No supported package manager found. Please install grub, efibootmgr and os-prober manually." >&2
fi

# Run os-prober if available
if command -v os-prober >/dev/null 2>&1; then
    echo "Running os-prober..."
    os-prober
fi

theme_root="$(dirname "$0")/themes"
if [ ! -d "$theme_root" ]; then
    echo "No themes directory found at $theme_root" >&2
    exit 1
fi

themes=("$theme_root"/*)
if [ ${#themes[@]} -eq 0 ]; then
    echo "No themes available in $theme_root" >&2
    exit 1
fi

PS3="Choose a theme: "
select theme in "${themes[@]}"; do
    if [ -n "$theme" ] && [ -d "$theme" ]; then
        chosen="$theme"
        break
    fi
    echo "Invalid selection." >&2
done

name=$(basename "$chosen")
dest="/boot/grub/themes/$name"

sudo mkdir -p /boot/grub/themes
sudo rm -rf "$dest"
sudo cp -r "$chosen" "$dest"

cfg_line="GRUB_THEME=\"$dest/theme.txt\""

if [ -f /etc/default/grub ]; then
    sudo sed -i '/^GRUB_THEME=/d' /etc/default/grub
fi
echo "$cfg_line" | sudo tee -a /etc/default/grub >/dev/null

sudo grub-mkconfig -o /boot/grub/grub.cfg

echo "Done."
