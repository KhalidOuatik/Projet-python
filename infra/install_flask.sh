#!/bin/bash
# Script d'installation pour VM Flask
set -e

sudo apt-get update
sudo apt-get install -y python3 python3-pip git unzip

# Installer gunicorn pour un serveur Flask production
sudo apt-get install -y gunicorn
pip3 install gunicorn

# Supposé être lancé depuis le dossier où release.zip a été copié
cd /tmp
unzip -o release.zip
pip3 install -r requirements.txt

# Lancer l'app Flask en mode production avec gunicorn
nohup gunicorn -b 0.0.0.0:5000 app:app &
