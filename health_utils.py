def calculate_bmi(height, weight):
    """
    J'ai créé cette fonction pour calculer l'Indice de Masse Corporelle (IMC).
    """
    if height <= 0 or weight <= 0:
        raise ValueError("La taille et le poids doivent être positifs")
    return weight / (height ** 2)

def calculate_bmr(height, weight, age, gender):
    """
    J'ai créé cette fonction pour calculer le Taux Métabolique de Base (BMR) en utilisant l'équation de Harris-Benedict.
    """
    if height <= 0 or weight <= 0 or age < 0:
        raise ValueError("La taille, le poids et l'âge doivent être positifs")
    
    if gender.lower() == 'male':
        return 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age)
    elif gender.lower() == 'female':
        return 447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age)
    else:
        raise ValueError("Le genre doit être 'male' ou 'female'")

