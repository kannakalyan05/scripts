#!/bin/bash

# List of archive and compression tools
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

# Start of script
clear
echo -e "[\e[1;33mINFO\e[0m] Archive and Compression Tools Installer"

read -rep $'\n[\e[1;33mACTION\e[0m] - Install common archive tools (zip, tar, unzip, etc)? (y/n): ' INST
if [[ "$INST" =~ ^[Yy]$ ]]; then
  echo -e "[\e[1;34mINSTALL\e[0m] Installing archive/compression packages..."
  yay -S --needed "${archive_tools[@]}"
  echo -e "\n[\e[1;32mDONE\e[0m] All archive tools installed."
else
  echo -e "[\e[1;31mCANCELLED\e[0m] Installation skipped."
fi
