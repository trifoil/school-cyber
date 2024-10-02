# Tache 2 : Synthese

1. **Destinations des messages syslog sur un périphérique Cisco** :
   - Dans une mémoire tampon locale sur le périphérique (accessible uniquement par CLI)
   - Dans la console (console 0)
   - Dans un terminal (vty)
   - Vers un serveur syslog externe sur le réseau 

2. **Niveaux de gravité syslog (de Cisco)** :
   - 0 : **Emergencies** (Urgence) – Système instable
   - 1 : **Alerts** (Alerte) – Action immédiate requise
   - 2 : **Critical** (Critique) – Conditions critiques
   - 3 : **Errors** (Erreur) – Conditions d'erreur
   - 4 : **Warnings** (Avertissement) – Conditions d'avertissement
   - 5 : **Notifications** (Notification) – Événement normal mais important
   - 6 : **Informational** (Informatif) – Message informatif
   - 7 : **Debugging** (Débogage) – Message de débogage 

3. **Notion de capacité syslog (syslog facility)** :
   - La capacité syslog est un identifiant qui spécifie l'appareil, le protocole ou le module générant le message syslog. Cela aide à organiser et à classifier les messages afin de faciliter leur gestion. Les valeurs de capacité dépendent du périphérique utilisé 

4. **Signification de SNMP** :
   - SNMP signifie **Simple Network Management Protocol**. Il permet de gérer les équipements réseau (modification de la configuration), de les superviser (collecte de données, vérifications), et de diagnostiquer des problèmes réseau 

5. **Composants de base d’un système SNMP** :
   - **Gestionnaire SNMP** (SNMP manager ou NMS – Network Management Server)
   - **Agents SNMP** (dispositifs gérés)
   - **MIB** (Management Information Base), base d’informations contenant les objets à gérer 

6. **Identification d'un objet de la MIB** :
   - Un objet de la MIB est identifié par un **OID** (Object Identifier), qui est une chaîne de nombres représentant la position unique de l'objet dans la structure arborescente de la MIB 

7. **Trouver l'identifiant d'un objet de la MIB** :
   - Il existe des outils comme le **MIB Browser** qui permettent de naviguer dans la MIB et de trouver les OIDs des objets

8. **Versions sécurisées de SNMP** :
   - La version sécurisée de SNMP est **SNMPv3**. Contrairement à SNMPv1 et SNMPv2c, elle intègre des mécanismes d'authentification, d'intégrité des données et de confidentialité 

9. **Les trois niveaux de sécurité de SNMPv3** :
   - **noAuthNoPriv** : pas d'authentification, pas de chiffrement
   - **AuthNoPriv** : authentification avec HMAC-MD5 ou HMAC-SHA, pas de chiffrement
   - **AuthPriv** : authentification avec HMAC-MD5 ou HMAC-SHA et chiffrement (DES, 3DES ou AES).

# Tâche 3 : Partie pratique

Configurer routeur et commutateur pour envoyer des messages syslog vers un serveur syslog.

Pour ce TP, utiliser le fichier Packet Tracer suivant :
    - TR3WAN_hyb_TP-syslog-Debut

Configurer le routeur R1 et le Commutateur S2 afin que les messages syslog de niveau debugging soient envoyés au serveur SRVsyslog. 

# Tache 4 : Réflexions méthodologiques