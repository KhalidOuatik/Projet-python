VENV = venv
PYTHON = $(VENV)/bin/python
PIP = $(VENV)/bin/pip

.PHONY: init run stop test build clean

init:
	@echo "Installation des dépendances..."
	python3 -m venv $(VENV)
	$(PIP) install -r requirements.txt

run:
	@echo "Lancement de l'application Flask en arrière-plan..."
	nohup $(PYTHON) app.py > flask.log 2>&1 &
	@echo "L'application est en cours d'exécution. Utilisez 'make stop' pour l'arrêter."

stop:
	@echo "Arrêt de l'application Flask..."
	-pkill -f "python app.py"

test:
	@echo "Exécution des tests..."
	$(PYTHON) -m unittest discover

build:
	@echo "Construction de l'image Docker..."
	docker build -t health-calculator-service .

clean:
	@echo "Nettoyage..."
	rm -rf $(VENV)
	find . -type f -name '*.pyc' -delete
	find . -type d -name '__pycache__' -delete
	rm -f flask.log

status:
	@echo "Vérification du statut de l'application..."
	@if pgrep -f "python app.py" > /dev/null; then \
        echo "L'application Flask est en cours d'exécution."; \
    else \
        echo "L'application Flask n'est pas en cours d'exécution."; \
    fi
