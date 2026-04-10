#!/bin/bash

# load config
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

# Search for the config in ~/.config/adu/ or fallback to the script directory
if [ -f "$HOME/.config/adu/config.conf" ]; then
    source "$HOME/.config/adu/config.conf"
elif [ -f "$SCRIPT_DIR/config.conf" ]; then
    source "$SCRIPT_DIR/config.conf"
else
    echo "❌ Configuration file not found."
    exit 1
fi

# Check if a file matches the pattern
DEB_FILE=$(ls -t "$DOWNLOAD_DIR"/$FILE_PATTERN 2>/dev/null | head -n 1)

if [ -z "$DEB_FILE" ]; then
    echo "❌ Aucun fichier $FILE_PATTERN trouvé dans $DOWNLOAD_DIR"
    exit 1
fi

echo "🚀 Installing: $(basename "$DEB_FILE")"

# Install the package
if sudo dpkg -i "$DEB_FILE"; then
    echo "✅ Installation successful"
    
    # Restart Discord
    echo "🔄 Restarting Discord..."
    setsid discord > /dev/null 2>&1 &
    
    rm "$DEB_FILE"
    echo "✅ Cleanup complete!"
else
    echo "❌ Error during installation. The file has been kept."
    exit 1
fi
