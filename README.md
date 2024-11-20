Health Calculator Microservice

Ce projet est un microservice Python qui calcule l'IMC (Indice de Masse Corporelle) et le BMR (Taux Métabolique de Base) via une API REST. Il est conteneurisé avec Docker et déployé sur Azure App Service via un pipeline CI/CD GitHub Actions.

## Prérequis

- Python 3.9+
- pip
- Docker
- Git
- Compte GitHub
- Compte Azure

## Installation

1. Installez les prérequis système :

   sudo apt-get update
   sudo apt-get install python3 python3-pip python3-venv


2. Clonez ce dépôt :

   git clone 
   cd health-calculator-service


3. Initialisez le projet :

   make init


## Utilisation

1. Lancez l'application :

   make run


2. Utilisez les endpoints :
- POST /bmi : `{"height": float, "weight": float}`
- POST /bmr : `{"height": float, "weight": float, "age": int, "gender": string}`

Exemple avec curl :

   curl -X POST -H "Content-Type: application/json" -d '{"height": 1.75, "weight": 70}' http://localhost:5000/bmi


3. Arrêtez l'application :

   make stop


## Tests

Exécutez les tests unitaires :

make test


## Déploiement

Le déploiement est automatisé via GitHub Actions. Chaque push sur la branche principale déclenche le pipeline CI/CD.

## Commandes utiles

- `make run` : Lance l'application
- `make stop` : Arrête l'application
- `make test` : Exécute les tests
- `make build` : Construit l'image Docker
- `make clean` : Nettoie les fichiers temporaires
- `make status` : Vérifie le statut de l'application
- `make logs` : Affiche les logs de l'application

## Contribution

Les pull requests sont les bienvenues. Pour les changements majeurs, veuillez d'abord ouvrir une issue pour discuter de ce que vous aimeriez changer.

Projet réalisé par Khalid OUATIK
