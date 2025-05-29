#!/bin/bash

archive_tools=(
  7zip
  bzip2
  cpio
  gzip
  libzip
  lzip
  lrzip
  lzop
  minizip
  p7zip
  tar
  unrar
  unzip
  xz
  zip
  zstd
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

# Clear screen and start script
clear
echo -e "[\e[1;33mINFO\e[0m] Archive and Compression Tools Installer"

read -rep $'\n[\e[1;33mACTION\e[0m] - Install common archive tools (zip, tar, unzip, etc)? (y/n): ' INST
if [[ "$INST" =~ ^[Yy]$ ]]; then
  for pkg in "${archive_tools[@]}"; do
    install_software "$pkg"
  done
  echo -e "\n[\e[1;32mDONE\e[0m] All archive tools installed."
else
  echo -e "[\e[1;31mCANCELLED\e[0m] Installation skipped."
fi
