
# Projet DevOps Python – Stack Azure, Docker, Ansible, Monitoring & CI/CD

## Présentation
Ce projet déploie automatiquement une stack applicative Python (Flask) monitorée (Prometheus, Grafana, node_exporter) sur Azure, avec infrastructure as code (Terraform), déploiement automatisé (Ansible, Docker), pipeline CI/CD GitHub Actions robuste, et tests d’intégration automatisés.

---

## Fonctionnalités principales
- **Infrastructure Azure** :
  - Provisionnement de 2 VMs (Flask + Monitoring) via Terraform
  - NSG, IPs publiques, VNet, Subnet, clés SSH
- **Déploiement applicatif** :
  - Dockerisation complète (Flask, Prometheus, Grafana, node_exporter)
  - Déploiement automatisé via Ansible (playbooks, rôles, inventaire dynamique)
  - Monitoring Prometheus/node_exporter, dashboard Grafana
  - Endpoint `/metrics` exposé par Flask, scrappé par Prometheus
- **CI/CD GitHub Actions** :
  - Build, tests unitaires, artefacts, déploiement infra/app, tests d’intégration
  - Génération dynamique de l’inventaire Ansible avec IPs et clés
  - Destruction/recréation idempotente de l’infra Azure
  - Vérification automatique de la présence des conteneurs sur les VMs
- **Tests d’intégration** :
  - Script Python (`integration_test.py`) pour tester Flask, Grafana, Prometheus
  - Logs détaillés, attente de services, vérification HTTP
- **Qualité de code** :
  - Analyse SonarQube Cloud (sécurité, fiabilité, maintenabilité, duplications)
  - Couverture de tests Python intégrée (coverage)

---

## Stack technique
- **Cloud** : Azure (VMs Ubuntu 20.04)
- **IaC** : Terraform
- **Déploiement** : Ansible, Docker, Docker Compose
- **App** : Python 3.9+, Flask, prometheus_flask_exporter
- **Monitoring** : Prometheus, Grafana, node_exporter
- **CI/CD** : GitHub Actions
- **Qualité** : SonarQube Cloud (SonarCloud)

---

## Pipeline CI/CD (GitHub Actions)
1. **Build**
   - Install Python, dépendances, tests unitaires
   - Génère l’artefact zip pour déploiement
   - Analyse SonarQube (qualité + couverture)
2. **Deploy**
   - Déploie l’infra Azure (import/destroy/apply)
   - Génère l’inventaire Ansible dynamique
   - Déploie les services via Ansible/Docker
   - Lance les tests d’intégration

---

## Lancer une analyse SonarQube Cloud
1. Créer un compte sur https://sonarcloud.io/ et lier le repo GitHub
2. Générer un token d’analyse et l’ajouter dans les secrets GitHub (`SONAR_TOKEN`)
3. Le pipeline CI/CD lance automatiquement l’analyse à chaque push
4. Résultats visibles sur SonarCloud (qualité, bugs, duplications, couverture)

---

## Badge SonarQube
Ajoute ce badge dans le README (remplace les valeurs par ton projet) :

```
[![SonarCloud](https://sonarcloud.io/images/project_badges/sonarcloud-orange.svg)](https://sonarcloud.io/summary/new_code?id=Projet-python)
```

---

## Lancer les tests d’intégration manuellement
```bash
pip install -r requirements.txt
python3 integration_test.py
```

---

## Structure du projet
- `app.py` : Application Flask
- `integration_test.py` : Tests d’intégration
- `Dockerfile` : Build Flask (Gunicorn)
- `docker/docker-compose.yml` : Stack monitoring
- `ansible/` : Playbooks, rôles, inventaire
- `infra/` : Fichiers Terraform
- `.github/workflows/ci-cd.yml` : Pipeline CI/CD
- `sonar-project.properties` : Config SonarQube

---

## Auteur
Projet DevOps complet – automatisé, monitoré, testé, industrialisé par Khalid OUATIK
