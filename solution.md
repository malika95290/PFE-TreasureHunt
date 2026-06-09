```
## Chaîne des indices — parcours complet

ÉTAPE 0   Email DGSI reçu dans Thunderbird
          → Photo jointe → steghide → identifiants t.lalimace / Hermes2017!

ÉTAPE 1   nmap -sV 192.168.56.10
          → Ports : 80, 22, 8080

ÉTAPE 2   Site AEGIS port 80
          → Accès collaborateur -> Profil Thomas → lien vers /intranet/login.php

ÉTAPE 3   Connexion intranet avec t.lalimace / Hermes2017!
          → Onglet Tickets  : ticket #4523 supprimé → contacter admin
          → Onglet Documents : accès restreint → saisir code admin

ÉTAPE 4   SQLi sur /intranet/login — bypass login
          → Identifiant : ' OR '1'='1
          → Accès panneau admin obtenu

ÉTAPE 5   Panneau admin — onglet Tickets
          → Ticket #4523 : message Thomas
            "communications espionnées — voir enregistrement dans mes documents"
          → Ticket #161 : échange direction/admin
            → code documents : AEGIS-2026-UNLOCK

ÉTAPE 6   Retour dashboard Thomas — onglet Documents
          → Code AEGIS-2026-UNLOCK → documents déverrouillés
          → Note_Vocale_Incident.wav → strings
            "preuves dans la bdd hermes — table surveillance"

ÉTAPE 7   SQLi — documents recherche panneau admin
          → UNION SELECT → tables → surveillance
          → UNION SELECT colonnes surveillance
          → UNION SELECT * FROM surveillance
            capture     : ghost-evidence.pcap
            chemin      : /var/log/hermes/

ÉTAPE 8   SSH — connexion avec mot de passe reconstitué
          → Onglet note : "nomChat"
          → nomChat      = felix (note croquettes onglet Notes)
          → ssh thomas@192.168.56.10 -p 22
          → Mot de passe : felix
          → thomas@aegis:~$ cp /var/log/hermes/ghost-evidence.pcap ~/
          → scp -P 22 thomas@192.168.56.10:~/ghost-evidence.pcap .

ÉTAPE 9  Wireshark — Follow TCP Stream
          → Clic droit sur un paquet → Follow → TCP Stream
          → Conversation HERMES (rouge) → KH-RELAY-02 (bleu)
          → Rapport mensuel Silent Wire : 847 Go exfiltrés
          → Réponse KH-RELAY-02 : accusé réception + clé validation
          → FLAG{S1L3NT_W1R3_TL_2026}

ÉTAPE F   Soumission sur http://192.168.56.10:8080
```
