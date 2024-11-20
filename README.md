# Health Calculator Microservice

Ce projet est un microservice Python qui calcule l'IMC (Indice de Masse Corporelle) et le BMR (Taux Métabolique de Base) via une API REST. Il est conteneurisé avec Docker et déployé sur Azure App Service via un pipeline CI/CD GitHub Actions.

## Prérequis

- Python 3.11+
- pip
- Git
- Compte GitHub (pour le fork et le déploiement)
- Compte Azure (pour le déploiement)

## Installation et Configuration Locale

1. Clonez ce dépôt :

   git clone https://github.com/votre-username/Projet-python.git
   cd Projet-python


2. Créez et activez un environnement virtuel :

   python -m venv venv
   source venv/bin/activate  # Sur Windows, utilisez venv\Scripts\activate


3. Installez les dépendances :

   pip install -r requirements.txt


## Exécution Locale

1. Lancez l'application :

   python app.py


2. L'application sera accessible à l'adresse `http://localhost:5000`

3. Testez les endpoints avec curl ou un outil similaire :

   curl -X POST -H "Content-Type: application/json" -d '{"height": 1.75, "weight": 70}' http://localhost:5000/bmi
   curl -X POST -H "Content-Type: application/json" -d '{"height": 175, "weight": 70, "age": 25, "gender": "male"}' http://localhost:5000/bmr


## Exécution des Tests

Pour exécuter les tests unitaires :

python -m unittest discover


## Déploiement sur Azure

Le déploiement est automatisé via GitHub Actions. Pour configurer le déploiement sur votre propre environnement Azure :

1. Forkez ce dépôt sur votre compte GitHub.

2. Créez une Web App sur Azure :
   - Allez sur le portail Azure et créez une nouvelle Web App.
   - Notez le nom de votre App Service.

3. Configurez les secrets GitHub :
   - Dans votre fork GitHub, allez dans Settings > Secrets and variables > Actions.
   - Ajoutez les secrets suivants :
     - `AZUREAPPSERVICE_CLIENTID`
     - `AZUREAPPSERVICE_TENANTID`
     - `AZUREAPPSERVICE_SUBSCRIPTIONID`
   (Vous pouvez obtenir ces valeurs depuis le portail Azure)

4. Mettez à jour le fichier `.github/workflows/ci-cd.yml` :
   - Remplacez `'python-projet'` par le nom de votre App Service Azure.

5. Poussez un changement sur la branche main pour déclencher le déploiement.

## Structure du Projet

- `app.py`: Point d'entrée de l'application Flask.
- `health_utils.py`: Fonctions utilitaires pour les calculs de santé.
- `test.py`: Tests unitaires.
- `requirements.txt`: Dépendances du projet.
- `.github/workflows/ci-cd.yml`: Configuration du workflow GitHub Actions.

Projet réalisé par Khalid OUATIK pour un projet Python/Azure
