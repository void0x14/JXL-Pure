#!/bin/bash
# JXL-Pure Quick Installer
# This script installs JXL-Pure to /usr/local/bin

set -e

REPO_URL="https://raw.githubusercontent.com/void0x14/JXL-Pure/main"
INSTALL_DIR="/usr/local/bin"

echo "💎 JXL-Pure Installer"
echo "----------------------"

# Check for dependencies
echo "Checking dependencies..."
for cmd in fd cjxl curl; do
    if ! command -v "$cmd" &>/dev/null; then
        echo "Error: '$cmd' is not installed."
        if [ -f /etc/arch-release ]; then
            echo "Try: sudo pacman -S fd libjxl curl"
        elif [ -f /etc/debian_version ]; then
            echo "Try: sudo apt install fd-find libjxl-tools curl"
        fi
        exit 1
    fi
done

# Download scripts
echo "Downloading scripts..."
curl -sSL "$REPO_URL/jxl-pure.sh" -o jxl-pure
curl -sSL "$REPO_URL/convert.fish" -o jxl-pure-fish

chmod +x jxl-pure jxl-pure-fish

# Install
echo "Installing to $INSTALL_DIR (requires sudo)..."
sudo mv jxl-pure jxl-pure-fish "$INSTALL_DIR/"

echo "----------------------"
echo "✅ JXL-Pure installed successfully!"
echo "Usage:"
echo "  Bash: jxl-pure [directory]"
echo "  Fish: jxl-pure-fish [directory]"
