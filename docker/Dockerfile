# Dockerfile pour l'app Flask
FROM python:3.11-slim
WORKDIR /app
COPY app/requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
# Copier les fichiers Python nécessaires
COPY app/app.py ./
COPY app/health_utils.py ./
COPY app/integration_test.py ./
COPY app/test.py ./
COPY app/test_integration.py ./
# Copier les templates si besoin
COPY app/templates ./templates
EXPOSE 5000
CMD ["gunicorn", "-b", "0.0.0.0:5000", "--worker-class", "gthread", "app:app"]
