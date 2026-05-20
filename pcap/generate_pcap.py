from scapy.all import *

# Le rapport de Thomas sans AUCUN accent (ASCII Pur)
rapport_thomas = """RAPPORT D'URGENCE - THOMAS LALIMACE - 21/05/2026 - 22h58
 
Objet : Compromission systemes AEGIS Technologies
Operation identifiee : SILENT WIRE
Backdoor active depuis mars 2022 - firmware HERMES v4.1
 
Unites militaires compromises :
- 12e Regiment du Genie
- 27e Bataillon de Chasseurs Alpins
- COMCYBER-ALPHA
 
Destinataire confirme : Secretariat General de la Defense et de la Securite Nationale (SGDSN)
Volume intercepte par Hermes : 847 Go depuis activation
 
Responsables impliques :
- Directeur Technique AEGIS
- DSI AEGIS
 
Clé de validation : FLAG{S1L3NT_W1R3_TL_2026}
 
[INTERCEPTION SYSTEME HERMES - COMPTE: tlalimace - STATUT: QUARANTAINE DECLENCHEE]"""

# Configuration de la fausse requete HTTP
http_payload = (
    "POST /transmission/secure-alert HTTP/1.1\r\n"
    "Host: alerte.ssi.gouv.fr\r\n"
    "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64)\r\n"
    "Content-Type: text/plain; charset=us-ascii\r\n"
    f"Content-Length: {len(rapport_thomas)}\r\n\r\n"
    + rapport_thomas
)

# Simulation des adresses IP et de la poignee de main TCP
ip = IP(src="192.168.10.115", dst="212.85.150.133")
syn = TCP(sport=52410, dport=80, flags="S", seq=1000)
syn_ack = TCP(sport=80, dport=52410, flags="SA", seq=2000, ack=1001)
ack = TCP(sport=52410, dport=80, flags="A", seq=1001, ack=2001)
data_pkt = ip/TCP(sport=52410, dport=80, flags="PA", seq=1001, ack=2001)/http_payload

# Generation du fichier final
wrpcap("hermes_dump_secure_extraction.pcap", [ip/syn, ip/syn_ack, ip/ack, data_pkt])
print("Fichier PCAP de capture automatique Hermes genere avec succes et sans accents !")