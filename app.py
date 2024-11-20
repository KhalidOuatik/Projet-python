from flask import Flask, request, jsonify
from health_utils import calculate_bmi, calculate_bmr

app = Flask(__name__)

@app.route('/')
def home():
    return "Bienvenue dans l'API de calcul de santé!"

@app.route('/bmi', methods=['POST'])
def bmi():
    """
    J'ai créé cet endpoint pour calculer l'IMC (Indice de Masse Corporelle).
    Il attend un JSON avec 'height' (en mètres) et 'weight' (en kg).
    """
    data = request.json
    try:
        height = float(data['height'])
        weight = float(data['weight'])
        result = calculate_bmi(height, weight)
        return jsonify({"bmi": result}), 200
    except KeyError:
        return jsonify({"error": "Les champs 'height' et 'weight' sont requis"}), 400
    except ValueError:
        return jsonify({"error": "Les valeurs de 'height' et 'weight' doivent être numériques"}), 400

@app.route('/bmr', methods=['POST'])
def bmr():
    """
    J'ai créé cet endpoint pour calculer le BMR (Taux Métabolique de Base).
    Il attend un JSON avec 'height' (en cm), 'weight' (en kg), 'age' (en années) et 'gender'.
    """
    data = request.json
    try:
        height = float(data['height'])
        weight = float(data['weight'])
        age = int(data['age'])
        gender = data['gender']
        result = calculate_bmr(height, weight, age, gender)
        return jsonify({"bmr": result}), 200
    except KeyError as e:
        return jsonify({"error": f"Le champ {str(e)} est manquant"}), 400
    except ValueError as e:
        return jsonify({"error": str(e)}), 400

if __name__ == '__main__':
    print("L'application Flask démarre...")
    app.run(host='127.0.0.1', port=5000, debug=True)
    print("L'application Flask s'est arrêtée.")

