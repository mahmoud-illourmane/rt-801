#!/usr/bin/env python3
import re

pattern = "Tomate"
text = "Voici une liste de ligumes : Tomate, Poireau, Aubergine."

match = re.search(pattern, text)

if not match:
    print("Aucune corréspondance trouvé.")
    exit(0)
    
start = match.start()
end = match.end()

print(f"{match.re.pattern} trouvé dans l'expression '{match.string}'\nentre {start}ème et {end}ème caractères")
exit(0)
