# fonctions.py
def puissance(a: int, b: int) -> int:
    if not (type(a) is int and type(b) is int):
        raise TypeError("Only integers are allowed")
    return a ** b




