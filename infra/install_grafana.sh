#!/bin/bash
# Script d'installation pour VM Grafana
set -e

sudo apt-get update
sudo apt-get install -y apt-transport-https software-properties-common wget

# Installer Grafana
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
echo "deb https://packages.grafana.com/oss/deb stable main" | sudo tee /etc/apt/sources.list.d/grafana.list
sudo apt-get update
sudo apt-get install -y grafana

sudo systemctl enable grafana-server
sudo systemctl start grafana-server

# Attendre que Grafana soit bien UP (max 60s)
for i in {1..12}; do
  if curl -s http://localhost:3000/api/health | grep -q '"database":' ; then
    echo "[INFO] Grafana est UP."
    break
  fi
  echo "[INFO] Attente de Grafana ($i/12)..."
  sleep 5
done

# Création automatique de la datasource Prometheus dans Grafana
echo "[INFO] Ajout automatique de la datasource Prometheus à Grafana..."
curl -s -X POST http://admin:admin@localhost:3000/api/datasources \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Prometheus",
    "type": "prometheus",
    "access": "proxy",
    "url": "http://localhost:9090",
    "isDefault": true
  }' | grep 'datasource' && echo "[OK] Datasource Prometheus ajoutée à Grafana."

# Attendre que Grafana soit bien démarré
echo "[INFO] Attente du démarrage de Grafana..."
sleep 15

# Création automatique de la datasource Prometheus dans Grafana
echo "[INFO] Ajout automatique de la datasource Prometheus à Grafana..."
curl -s -X POST http://admin:admin@localhost:3000/api/datasources \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Prometheus",
    "type": "prometheus",
    "access": "proxy",
    "url": "http://localhost:9090",
    "isDefault": true
  }' | grep 'datasource' && echo "[OK] Datasource Prometheus ajoutée à Grafana."
