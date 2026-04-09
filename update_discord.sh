#!/bin/bash

# Chargement de la config
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
source "$SCRIPT_DIR/config.conf"

# Vérification si un fichier correspond au pattern
DEB_FILE=$(ls -t $DOWNLOAD_DIR/$FILE_PATTERN 2>/dev/null | head -n 1)

if [ -z "$DEB_FILE" ]; then
    echo "❌ Aucun fichier $FILE_PATTERN trouvé dans $DOWNLOAD_DIR"
    exit 1
fi

echo "🚀 Installation de : $(basename "$DEB_FILE")"

# Installation (demande le mot de passe sudo)
sudo dpkg -i "$DEB_FILE"

# Correction des dépendances si nécessaire
#sudo apt-get install -f -y

# Relancer Discord
echo "🔄 Redémarrage de Discord..."
#pkill -9 Discord
nohup discord > /dev/null 2>&1 &

# Nettoyage : supprimer le .deb après install (optionnel)
rm "$DEB_FILE"

echo "✅ Mise à jour terminée !"
