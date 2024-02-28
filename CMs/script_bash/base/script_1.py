# -*- coding: utf-8 -*-
# Importe le module datetime pour obtenir la date actuelle
from datetime import datetime
    
# Affiche un message avec la date actuelle
print("Nous sommes le", datetime.now().strftime("%d/%m/%Y"))
    
# Quitte le script avec succès
exit(0)