# fonctions.py
def puissance(a: int, b: int) -> float:
    # Q2.4 : uniquement des entiers
    if type(a) is not int or type(b) is not int:
        raise TypeError("Only integers are allowed")

    # 0^x avec x < 0 est indéfini
    if a == 0 and b < 0:
        raise ZeroDivisionError("0^b est indéfini pour b < 0")

    # a^0 = 1 , 0^0 = 1
    if b == 0:
        return 1.0

    # Calcul pas d'opérateur **
    n = abs(b)
    res = 1
    for _ in range(n):
        res *= a

    # Exposant négatif → inverse
    return float(res) if b > 0 else 1.0 / res





