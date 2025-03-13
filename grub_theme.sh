#!/bin/bash

install_grub_theme() {
  read -rep $'[\e[1;33mACTION\e[0m] - Would you like to install the Grub theme? (y,n) ' INST
  if [[ $INST =~ ^[Yy]$ ]]; then
    
    # Ask user for installation directory
    read -rep $'[\e[1;34mINPUT\e[0m] - Enter the installation directory for the Grub theme or boot loader installation path (Example: /boot or /boot/efi): ' INSTALL_DIR
    
    # Ensure the directory exists
    sudo mkdir -p "$INSTALL_DIR/grub/themes"
    sudo rm -rf "$INSTALL_DIR/grub/themes/CyberEXS"

    # Check if git is installed
    if ! command -v git &>/dev/null; then
      echo "[ERROR] 'git' is not installed. Please install it and try again."
      exit 1
    fi

    # Clone the theme
    sudo git clone https://github.com/kannakalyan05/GrubTheme.git "$INSTALL_DIR/grub/themes/CyberEXS"

    # Add/Replace GRUB_THEME line in /etc/default/grub
    if grep -q "^GRUB_THEME=" /etc/default/grub; then
      sudo sed -i "s|^GRUB_THEME=.*|GRUB_THEME=\"$INSTALL_DIR/grub/themes/CyberEXS/theme.txt\"|" /etc/default/grub
    else
      echo "GRUB_THEME=\"$INSTALL_DIR/grub/themes/CyberEXS/theme.txt\"" | sudo tee -a /etc/default/grub
    fi

    # Add reboot and shutdown menu entries if not already added
    if ! grep -q "menuentry \"Reboot\"" /etc/grub.d/40_custom; then
      echo -e '\nmenuentry "Reboot" {\n\treboot\n}' | sudo tee -a /etc/grub.d/40_custom
    fi

    if ! grep -q "menuentry \"Shut Down\"" /etc/grub.d/40_custom; then
      echo -e '\nmenuentry "Shut Down" {\n\thalt\n}' | sudo tee -a /etc/grub.d/40_custom
    fi

    # Update grub config
    if command -v grub-mkconfig &>/dev/null; then
      echo "[INFO] Updating grub configuration..."
      sudo grub-mkconfig -o /boot/grub/grub.cfg
    else
      echo "[WARNING] grub-mkconfig not found. Please update grub.cfg manually."
    fi

    echo "[DONE] Grub theme installation completed."
  else
    echo "[SKIPPED] Grub theme installation skipped."
  fi
}

# Run the function
install_grub_theme

