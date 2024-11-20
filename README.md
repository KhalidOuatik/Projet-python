# Health Calculator Microservice

Ce projet est un microservice Python qui calcule l'IMC et le BMR via une API REST. Il est conteneurisé avec Docker et déployé sur Azure App Service via GitHub Actions.

## Prérequis

- Python 3.9+
- Docker
- Make
- Compte GitHub
- Compte Azure

## Installation

1. Clonez ce dépôt:

   git clone https://github.com/votre-username/health-calculator-service.git
   cd health-calculator-service


2. Installez les dépendances:

   make init


## Utilisation

- Exécuter l'application localement:

  make run


- Exécuter les tests:

  make test


- Construire l'image Docker:

  make build


## API Endpoints

- POST /bmi : Calcule l'IMC
- Body: { "height": float, "weight": float }
- POST /bmr : Calcule le BMR
- Body: { "height": float, "weight": float, "age": int, "gender": string }

## Déploiement

Le déploiement est automatisé via GitHub Actions. Chaque push sur la branche principale déclenche le pipeline CI/CD.

## Contribution

Les pull requests sont les bienvenues. Pour les changements majeurs, ouvrez d'abord une issue.
