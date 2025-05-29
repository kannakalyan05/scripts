#!/bin/bash

# Get the directory where this script is located
SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "📁 Source directory: $SRC_DIR"
echo "⚙️  Starting hardcoded theme/config/background installation..."

# -----------------------------
# 1. Bibata-Modern-Classic → ~/.icons
echo -e "\n🎨 Installing Bibata-Modern-Classic to ~/.icons"
DEST="$HOME/.icons/Bibata-Modern-Classic"
mkdir -p "$HOME/.icons"
if [[ -d "$DEST" ]]; then
    echo "🗑️ Removing existing $DEST"
    rm -rf "$DEST"
fi
cp -r "$SRC_DIR/Bibata-Modern-Classic" "$HOME/.icons/"

# -----------------------------
# 2. xfce4 → ~/.config
echo -e "\n🛠 Installing xfce4 to ~/.config"
DEST="$HOME/.config/xfce4"
mkdir -p "$HOME/.config"
if [[ -d "$DEST" ]]; then
    echo "🗑️ Removing existing $DEST"
    rm -rf "$DEST"
fi
cp -r "$SRC_DIR/xfce4" "$HOME/.config/"

# -----------------------------
# 3. Flat-Remix-Blue-Dark → /usr/share/icons
echo -e "\n🎨 Installing Flat-Remix-Blue-Dark to /usr/share/icons"
DEST="/usr/share/icons/Flat-Remix-Blue-Dark"
sudo mkdir -p /usr/share/icons
if sudo test -d "$DEST"; then
    echo "🗑️ Removing existing $DEST"
    sudo rm -rf "$DEST"
fi
sudo cp -r "$SRC_DIR/Flat-Remix-Blue-Dark" /usr/share/icons/

# -----------------------------
# 4. Kali-Dark → /usr/share/themes
echo -e "\n🖼 Installing Kali-Dark to /usr/share/themes"
DEST="/usr/share/themes/Kali-Dark"
sudo mkdir -p /usr/share/themes
if sudo test -d "$DEST"; then
    echo "🗑️ Removing existing $DEST"
    sudo rm -rf "$DEST"
fi
sudo cp -r "$SRC_DIR/Kali-Dark" /usr/share/themes/

# -----------------------------
# 5. lightdm → /etc/lightdm
echo -e "\n🔒 Installing lightdm config to /etc/lightdm"
DEST="/etc/lightdm"
if sudo test -d "$DEST"; then
    echo "🗑️ Removing existing $DEST"
    sudo rm -rf "$DEST"
fi
sudo cp -r "$SRC_DIR/lightdm" /etc/

# -----------------------------
# 6. paradox → /usr/share/backgrounds
echo -e "\n🖼 Installing paradox to /usr/share/backgrounds"
DEST="/usr/share/backgrounds/paradox"
sudo mkdir -p /usr/share/backgrounds
if sudo test -d "$DEST"; then
    echo "🗑️ Removing existing $DEST"
    sudo rm -rf "$DEST"
fi
sudo cp -r "$SRC_DIR/paradox" /usr/share/backgrounds/

# -----------------------------
echo -e "\n✅ All themes, configs, and backgrounds installed successfully!"
