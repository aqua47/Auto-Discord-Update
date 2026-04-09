#!/bin/bash
# Utilise le chemin absolu vers ton dossier actuel
SCRIPT_PATH="/home/aqua47/Documents/code/ADU"
source "$SCRIPT_PATH/config.conf"

# Vérifie si le dossier de téléchargement existe pour éviter que inotifywait crash
if [ ! -d "$DOWNLOAD_DIR" ]; then
    echo "Erreur: Le dossier $DOWNLOAD_DIR n'existe pas."
    exit 1
fi

echo "👀 Surveillance de $DOWNLOAD_DIR..."

# On utilise inotifywait en mode moniteur (-m)
inotifywait -m "$DOWNLOAD_DIR" -e close_write |
    while read path action file; do
        if [[ "$file" == discord-*.deb ]]; then
            echo "✨ Nouveau paquet détecté : $file"
            sleep 2
            # Sous KDE, on utilise konsole
            konsole -e "$SCRIPT_PATH/update_discord.sh"
        fi
    done
