# Utiliser une image Python officielle
FROM python:3.9-slim

# Définir le répertoire de travail
WORKDIR /app

# Copier les fichiers nécessaires
COPY . /app

# Installer les dépendances
RUN pip install --no-cache-dir -r requirements.txt

# Exposer le port
EXPOSE 5000

# Commande pour exécuter l'application avec Gunicorn (worker gthread)
CMD ["gunicorn", "-b", "0.0.0.0:5000", "--worker-class", "gthread", "app:app"]

