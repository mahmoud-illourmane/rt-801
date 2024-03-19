import subprocess
import os
import sys

# Vérification du nombre de paramètres
if len(sys.argv) != 6:
    print("\033[31mUsage: {} <nom_archive> <repertoire_a_sauvegarder> \"adresse_serveur_sauvegarde\" \"login\" \"password\"\033[0m".format(sys.argv[0]))
    exit(1)

# Attribution des paramètres à des variables
NOM_ARCHIVE = sys.argv[1]
REPERTOIRE_A_SAUVEGARDER = sys.argv[2]
ADRESSE_SERVEUR = sys.argv[3]
LOGIN = sys.argv[4]
PASSWORD = sys.argv[5]

# Création de l'archive avec tar
subprocess.run(['tar', '-czf', NOM_ARCHIVE + '.tar.gz', REPERTOIRE_A_SAUVEGARDER])
print("\033[32mL'archive a bien été créée.\033[0m")

# Copie de l'archive via SFTP
processus_sftp = subprocess.Popen(['sshpass', '-p', PASSWORD, 'sftp', '{}@{}'.format(LOGIN, ADRESSE_SERVEUR)],
                                  stdin=subprocess.PIPE, text=True)
sortie_sftp, erreur_sftp = processus_sftp.communicate('put ' + NOM_ARCHIVE + '.tar.gz /home/' + LOGIN + '/archives\nbye\n')

# Vérification du retour de la commande SFTP
if erreur_sftp:
    print("\033[31mÉchec de la connexion SFTP : {}\033[0m".format(erreur_sftp.strip()))
    exit(1)

print("\033[32mSauvegarde terminée : {}.tar.gz a été copié sur {}\033[0m".format(NOM_ARCHIVE, ADRESSE_SERVEUR))
exit(0)
