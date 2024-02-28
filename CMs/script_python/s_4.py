#!/usr/bin/env python3
import sys

print("Ecrivez plusieurs noms de fruits non à la suite..")
print("Quand vous aurez fini cliquer sur CTRL+D")
fruits = sys.stdin.readlines()

print("Vous avez saisi les fruits suivants:")
for fruit in fruits:
    print(fruit.strip())
    
exit(0)