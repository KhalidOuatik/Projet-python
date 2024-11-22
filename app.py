from flask import Flask, request, jsonify, render_template
from health_utils import calculate_bmi, calculate_bmr
import logging

app = Flask(__name__)
logging.basicConfig(level=logging.INFO)

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/bmi', methods=['POST'])
def bmi():
    try:
        data = request.json
        app.logger.info(f"Received BMI data: {data}")
        height = float(data['height']) / 100  # Convert cm to meters
        weight = float(data['weight'])
        result = calculate_bmi(height, weight)
        app.logger.info(f"Calculated BMI: {result}")
        return jsonify({"bmi": result})
    except Exception as e:
        app.logger.error(f"Error calculating BMI: {str(e)}")
        return jsonify({"error": "Une erreur est survenue lors du calcul de l'IMC."}), 500

@app.route('/bmr', methods=['POST'])
def bmr():
    try:
        data = request.json
        app.logger.info(f"Received BMR data: {data}")
        height = float(data['height'])
        weight = float(data['weight'])
        age = int(data['age'])
        gender = data['gender']
        result = calculate_bmr(height, weight, age, gender)
        app.logger.info(f"Calculated BMR: {result}")
        return jsonify({"bmr": result})
    except Exception as e:
        app.logger.error(f"Error calculating BMR: {str(e)}")
        return jsonify({"error": "Une erreur est survenue lors du calcul du BMR."}), 500

if __name__ == '__main__':
    app.run(debug=True)

