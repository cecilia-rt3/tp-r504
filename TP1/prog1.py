print("Hello, World!")

# prog1.py
import fonctions as f

print("Boucle infinie — CTRL-C pour quitter.\n")

while True:
        a = int(input("Entrez un nombre (entier ou décimal) : "))
        b = int(input("Entrez un nombre (entier ou décimal) : "))

        res = f.puissance(a, b)
        print(f"Carré de {a} = {res}\n")



