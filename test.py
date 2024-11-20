import unittest
from health_utils import calculate_bmi, calculate_bmr
from app import app

class TestHealthUtils(unittest.TestCase):
    def test_calculate_bmi(self):
        """Je teste ici le calcul de l'IMC"""
        self.assertAlmostEqual(calculate_bmi(1.75, 70), 22.86, places=2)
        
    def test_calculate_bmr_male(self):
        """Je teste ici le calcul du BMR pour un homme"""
        self.assertAlmostEqual(calculate_bmr(175, 70, 25, 'male'), 1724.05, places=2)

    def test_calculate_bmr_female(self):
        """Je teste ici le calcul du BMR pour une femme"""
        self.assertAlmostEqual(calculate_bmr(160, 60, 30, 'female'), 1368.19, places=2)

class TestFlaskApp(unittest.TestCase):
    def setUp(self):
        """Je configure ici l'application pour les tests"""
        self.app = app.test_client()
        self.app.testing = True 

    def test_bmi_endpoint(self):
        """Je teste ici l'endpoint /bmi"""
        response = self.app.post('/bmi', json={'height': 1.75, 'weight': 70})
        self.assertEqual(response.status_code, 200)
        data = response.get_json()
        self.assertAlmostEqual(data['bmi'], 22.86, places=2)

    def test_bmr_endpoint(self):
        """Je teste ici l'endpoint /bmr"""
        response = self.app.post('/bmr', json={'height': 175, 'weight': 70, 'age': 25, 'gender': 'male'})
        self.assertEqual(response.status_code, 200)
        data = response.get_json()
        self.assertAlmostEqual(data['bmr'], 1724.05, places=2)

if __name__ == '__main__':
    unittest.main()

