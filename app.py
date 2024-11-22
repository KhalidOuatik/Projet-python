from flask import Flask, request, jsonify, render_template
from health_utils import calculate_bmi, calculate_bmr

app = Flask(__name__)

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/bmi', methods=['POST'])
def bmi():
    # Assurez-vous qu'il y a du code ici, indenté correctement
    data = request.json
    height = data['height']
    weight = data['weight']
    result = calculate_bmi(height, weight)
    return jsonify({"bmi": result})

@app.route('/bmr', methods=['POST'])
def bmr():
    # Assurez-vous qu'il y a du code ici, indenté correctement
    data = request.json
    height = data['height']
    weight = data['weight']
    age = data['age']
    gender = data['gender']
    result = calculate_bmr(height, weight, age, gender)
    return jsonify({"bmr": result})

if __name__ == '__main__':
    app.run(debug=True)

