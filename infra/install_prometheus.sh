#!/bin/bash
# Script d'installation Prometheus + node_exporter pour VM Grafana
set -e

# Variables
PROM_VERSION=2.52.0
NODE_EXPORTER_VERSION=1.8.1
PROM_USER=prometheus
PROM_DIR=/opt/prometheus

# Installer Prometheus
wget -q https://github.com/prometheus/prometheus/releases/download/v${PROM_VERSION}/prometheus-${PROM_VERSION}.linux-amd64.tar.gz
sudo tar xvf prometheus-${PROM_VERSION}.linux-amd64.tar.gz -C /opt/
sudo mv /opt/prometheus-${PROM_VERSION}.linux-amd64 $PROM_DIR
sudo useradd --no-create-home --shell /bin/false $PROM_USER || true
sudo chown -R $PROM_USER:$PROM_USER $PROM_DIR

# Créer le service systemd Prometheus
sudo tee /etc/systemd/system/prometheus.service > /dev/null <<EOF
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=$PROM_DIR/prometheus \
  --config.file=$PROM_DIR/prometheus.yml \
  --storage.tsdb.path=$PROM_DIR/data

[Install]
WantedBy=multi-user.target
EOF

# Installer node_exporter
wget -q https://github.com/prometheus/node_exporter/releases/download/v${NODE_EXPORTER_VERSION}/node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz
sudo tar xvf node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz -C /opt/
sudo mv /opt/node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64/node_exporter /usr/local/bin/
sudo chown $PROM_USER:$PROM_USER /usr/local/bin/node_exporter

# Créer le service systemd node_exporter
sudo tee /etc/systemd/system/node_exporter.service > /dev/null <<EOF
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target
EOF

# Ajouter node_exporter comme target dans prometheus.yml
sudo sed -i '/scrape_configs:/a \\n  - job_name: "node_exporter"\n    static_configs:\n      - targets: ["localhost:9100"]' $PROM_DIR/prometheus.yml

# Démarrer les services
sudo systemctl daemon-reload
sudo systemctl enable prometheus
sudo systemctl start prometheus
sudo systemctl enable node_exporter
sudo systemctl start node_exporter

echo "Prometheus et node_exporter installés et démarrés."
echo "Prometheus: http://localhost:9090/"
echo "Node exporter: http://localhost:9100/"
