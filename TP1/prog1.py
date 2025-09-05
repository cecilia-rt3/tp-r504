# prog1.py
print("Hello, World!")

import fonctions as f

print("CTRL-C pour quitter")

while True:
        a = int(input("Entrez un nombre a (ENTIER) : "))
        b = int(input("Entrez un nombre b (ENTIER) : "))
        res = f.puissance(a, b)
        print("La puissance donne: ",res)


