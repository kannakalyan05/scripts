#!/bin/bash

# Combined XFCE4 + LightDM + Greeter packages
main_packages=(
  xfce4
  lightdm
  lightdm-gtk-greeter
  lightdm-gtk-greeter-settings
)

# Extra packages (customize as needed)
extra_packages=(
  thunar-archive-plugin
  network-manager-applet
  gvfs
  xdg-user-dirs
  xfce4-whiskermenu-plugin
  xfce4-cpugraph-plugin
  xfce4-whiskermenu-plugin
)

# Function to install software
install_software() {
  if yay -Q "$1" &>/dev/null; then
    echo -e "[\e[1;32mINFO\e[0m] $1 is already installed."
  else
    echo -e "[\e[1;34mINSTALL\e[0m] Installing $1..."
    yay -S --needed "$1"
  fi
}

clear
echo -e "[\e[1;33mINFO\e[0m] XFCE4 and LightDM Setup Script"

# Install main desktop and login manager packages
read -rep $'\n[\e[1;33mACTION\e[0m] - Install XFCE4 and LightDM? (y/n): ' INST
if [[ "$INST" =~ ^[Yy]$ ]]; then
  for pkg in "${main_packages[@]}"; do
    install_software "$pkg"
  done

  # Enable LightDM
  echo -e "[\e[1;34mSYSTEMD\e[0m] Enabling LightDM service..."
  sudo systemctl enable lightdm.service
fi

# Optional: install extra packages
read -rep $'\n[\e[1;33mACTION\e[0m] - Install extra XFCE utilities and tools? (y/n): ' INST
if [[ "$INST" =~ ^[Yy]$ ]]; then
  for pkg in "${extra_packages[@]}"; do
    install_software "$pkg"
  done
fi

echo -e "\n[\e[1;32mDONE\e[0m] Setup complete. Reboot to start XFCE."

