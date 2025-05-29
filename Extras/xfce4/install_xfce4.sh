#!/bin/bash

# Core XFCE + LightDM + Greeter packages
main_packages=(
  lightdm
  lightdm-gtk-greeter
  lightdm-gtk-greeter-settings
  xfce4
)

# Extra XFCE utilities and plugins
extra_packages=(
  gvfs
  network-manager-applet
  thunar-archive-plugin
  xdg-user-dirs
  xfce4-cpugraph-plugin
  xfce4-whiskermenu-plugin
)

# Function to install a package if it's not already installed
install_software() {
  if yay -Q "$1" &>/dev/null; then
    echo -e "[\e[1;32mINFO\e[0m] $1 is already installed."
  else
    echo -e "[\e[1;34mINSTALL\e[0m] Installing $1..."
    yay -S --needed "$1"
  fi
}

# Start of script
clear
echo -e "[\e[1;33mINFO\e[0m] XFCE4 and Archive Tool Installer Script"

# Install XFCE and LightDM
read -rep $'\n[\e[1;33mACTION\e[0m] - Install XFCE4 and LightDM? (y/n): ' INST
if [[ "$INST" =~ ^[Yy]$ ]]; then
  for pkg in "${main_packages[@]}"; do
    install_software "$pkg"
  done

  echo -e "[\e[1;34mSYSTEMD\e[0m] Enabling LightDM..."
  sudo systemctl enable lightdm.service
fi

# Install extra XFCE utilities
read -rep $'\n[\e[1;33mACTION\e[0m] - Install extra XFCE utilities and plugins? (y/n): ' INST
if [[ "$INST" =~ ^[Yy]$ ]]; then
  for pkg in "${extra_packages[@]}"; do
    install_software "$pkg"
  done
fi

# Install archive tools from external script
read -rep $'\n[\e[1;33mACTION\e[0m] - Install archive and compression tools (zip, tar, etc)? (y/n): ' INST
if [[ "$INST" =~ ^[Yy]$ ]]; then
  ARCHIVER_SCRIPT="$(dirname "$0")/../install_archivers.sh"
  if [[ -x "$ARCHIVER_SCRIPT" ]]; then
    bash "$ARCHIVER_SCRIPT"
  else
    echo -e "[\e[1;31mERROR\e[0m] Could not find or execute: $ARCHIVER_SCRIPT"
  fi
fi

echo -e "\n[\e[1;32mDONE\e[0m] Installation complete. You may now reboot to start XFCE."
