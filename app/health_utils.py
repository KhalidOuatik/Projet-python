def calculate_bmi(height, weight):
    """
    Calcule l'Indice de Masse Corporelle (IMC).
    La taille (height) doit être en mètres et le poids (weight) en kilogrammes.
    """
    if height <= 0 or weight <= 0:
        raise ValueError("La taille et le poids doivent être positifs")
    return round(weight / (height ** 2), 2)

def calculate_bmr(height, weight, age, gender):
    """
    Calcule le Taux Métabolique de Base (BMR) en utilisant l'équation de Harris-Benedict.
    La taille (height) doit être en cm, le poids (weight) en kg, et l'âge en années.
    """
    if height <= 0 or weight <= 0 or age < 0:
        raise ValueError("La taille, le poids et l'âge doivent être positifs")
    
    if gender.lower() == 'male':
        bmr = 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age)
    elif gender.lower() == 'female':
        bmr = 447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age)
    else:
        raise ValueError("Le genre doit être 'male' ou 'female'")

    return round(bmr, 2)

