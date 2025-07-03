#!/bin/bash
# Script d'installation pour VM Flask
set -e

sudo apt-get update
sudo apt-get install -y python3 python3-pip git

# Clone le repo (remplace par ton repo si besoin)
git clone https://github.com/<TON-UTILISATEUR>/<TON-REPO>.git app
cd app
pip3 install -r requirements.txt

# Lancer l'app Flask (adapter si besoin)
nohup python3 app.py &
