#!/bin/bash

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

# Search for the config file
if [ -f "$HOME/.config/adu/config.conf" ]; then
    source "$HOME/.config/adu/config.conf"
elif [ -f "$SCRIPT_DIR/config.conf" ]; then
    source "$SCRIPT_DIR/config.conf"
else
    echo "Error: Configuration file not found."
    exit 1
fi

# Check if the download directory exists to prevent inotifywait from crashing
if [ ! -d "$DOWNLOAD_DIR" ]; then
    echo "Error: The directory $DOWNLOAD_DIR does not exist."
    exit 1
fi

echo "👀 Monitoring $DOWNLOAD_DIR..."

# Use inotifywait in monitor mode (-m)
inotifywait -m "$DOWNLOAD_DIR" -e close_write |
    while read path action file; do
        if [[ "$file" == $FILE_PATTERN ]]; then
            echo "✨ New package detected: $file"
            sleep 5
            # Under KDE, use konsole to prompt for sudo password
            konsole -e "$SCRIPT_DIR/update_discord.sh"
        fi
    done
