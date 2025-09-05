print("Hello, World!")

# prog1.py
import fonctions as f

print("CTRL-C pour quitter")

while True:
      try:
         a = int(input("Entrez un nombre a (entier ou décimal) : "))
         b = int(input("Entrez un nombre b (entier ou décimal) : "))

         res = f.puissance(a, b)
         print(res)
      
      except ValueError:
          print("Vuillez entrer des entiers")
      except KeyboardInterrupt:
          print("Au revoir")
          break

try:
   f.puissance(2.0,3.0)
except TypeError as e:
    print ("Ok: ", e) 


