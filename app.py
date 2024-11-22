from flask import Flask, request, jsonify, render_template
from health_utils import calculate_bmi, calculate_bmr

app = Flask(__name__)

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/bmi', methods=['POST'])
def bmi():
    # Votre code pour le calcul de l'IMC

@app.route('/bmr', methods=['POST'])
def bmr():
    # Votre code pour le calcul du BMR

if __name__ == '__main__':
    app.run(debug=True)

