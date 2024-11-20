# Health Calculator Microservice

Ce projet est un microservice Python qui calcule l'IMC (Indice de Masse Corporelle) et le BMR (Taux Métabolique de Base) via une API REST. Il est conteneurisé avec Docker et déployé sur Azure App Service via un pipeline CI/CD GitHub Actions.

## Prérequis

- Python 3.9+
- pip
- Docker
- Git
- Compte GitHub
- Compte Azure (pour le déploiement)

## Installation

1. Clonez ce dépôt :

   git clone https://github.com/KhalidOuatik/Projet-python.git
   cd Projet-python


2. Installez les dépendances :

   pip install -r requirements.txt


## Configuration pour le développement local

1. Créez un environnement virtuel :

   python -m venv venv


2. Activez l'environnement virtuel :
- Sur Windows :
  ```
  venv\Scripts\activate
  ```
- Sur macOS et Linux :
  ```
  source venv/bin/activate
  ```

3. Installez les dépendances du projet :

   pip install -r requirements.txt


## Utilisation

1. Lancez l'application :

   python app.py


2. L'application sera accessible à l'adresse `http://localhost:5000`

3. Utilisez les endpoints :
- POST /bmi : `{"height": float, "weight": float}`
- POST /bmr : `{"height": float, "weight": float, "age": int, "gender": string}`

Exemple avec curl :

   curl -X POST -H "Content-Type: application/json" -d '{"height": 1.75, "weight": 70}' http://localhost:5000/bmi


## Tests

Exécutez les tests unitaires :

python -m unittest discover


## Déploiement

Le déploiement est automatisé via GitHub Actions. Chaque push sur la branche principale déclenche le pipeline CI/CD.

Pour configurer le déploiement sur votre propre environnement Azure :

1. Créez une Web App sur Azure.
2. Dans les paramètres de votre dépôt GitHub, ajoutez les secrets suivants :
   - AZURE_WEBAPP_NAME : Le nom de votre Web App Azure
   - AZURE_WEBAPP_PUBLISH_PROFILE : Le profil de publication de votre Web App (téléchargeable depuis le portail Azure)

3. Mettez à jour le fichier `.github/workflows/main_python-projet.yml` avec le nom de votre application Azure.

Projet réalisé par Khalid OUATIK
