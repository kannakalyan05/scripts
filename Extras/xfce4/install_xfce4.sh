#!/bin/bash

# Core XFCE + LightDM + Greeter packages
main_packages=(
  xfce4
  lightdm
  lightdm-gtk-greeter
  lightdm-gtk-greeter-settings
)

# Extra XFCE utilities and plugins
extra_packages=(
  gvfs
  xdotool
  network-manager-applet
  thunar-archive-plugin
  xdg-user-dirs
  xfce4-cpugraph-plugin
  xfce4-clipman-plugin
  xfce4-pulseaudio-plugin
  xfce4-whiskermenu-plugin
  xfce4-screensaver
  xfce4-power-manager
  ttf-firacode-nerd
)

clear
echo -e "[\e[1;33mINFO\e[0m] XFCE4 and Archive Tool Installer Script"

# Install XFCE and LightDM
read -rep $'\n[\e[1;33mACTION\e[0m] - Install XFCE4 and LightDM? (y/n): ' INST
if [[ "$INST" =~ ^[Yy]$ ]]; then
  echo -e "[\e[1;34mINSTALL\e[0m] Installing XFCE4 and LightDM packages..."
  yay -S --needed "${main_packages[@]}"

  echo -e "[\e[1;34mSYSTEMD\e[0m] Enabling LightDM..."
  sudo systemctl enable lightdm.service
fi

# Install extra XFCE utilities
read -rep $'\n[\e[1;33mACTION\e[0m] - Install extra XFCE utilities and plugins? (y/n): ' INST
if [[ "$INST" =~ ^[Yy]$ ]]; then
  echo -e "[\e[1;34mINSTALL\e[0m] Installing extra XFCE packages..."
  yay -S --needed "${extra_packages[@]}"
fi

# Run archive tool installer script
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
