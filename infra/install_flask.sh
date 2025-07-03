#!/bin/bash
# Script d'installation pour VM Flask
set -e

sudo apt-get update
sudo apt-get install -y python3 python3-pip git

# Supposé être lancé depuis le dossier où release.zip a été copié
cd /tmp
unzip -o release.zip
pip3 install -r requirements.txt

# Lancer l'app Flask (adapter si besoin)
nohup python3 app.py &
