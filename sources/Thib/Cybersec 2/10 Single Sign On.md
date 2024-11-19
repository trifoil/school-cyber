#Cybersec_2_index 
[[Bac_3_Index]]
___
### Single Sign-On (SSO) 
- Authentification unique 
	- Après avoir été identifiés une première fois, les utilisateurs peuvent accéder à diverses ressources du réseau : 
		- Sans avoir à saisir à nouveau leurs identifiants. 
		- Indépendamment de la plate-forme, de la technologie ou du domaine. 
- La première authentification se fait auprès d'un serveur d'authentification 
	- Annuaires 
		- Active Directory ou NTLM pour les réseaux Microsoft. 
		- eDirectory pour les réseaux Novell. 
	- Serveur AAA 
		- Serveur RADIUS. 
		- FortiAuthenticator est un serveur AAA qui comprend un serveur RADIUS, un serveur LDAP et peut remplacer l'agent de collecte FSSO sur un réseau Windows AD.

### Fortinet Single Sign-On agents 
- Agent logiciel Fortinet utilisé pour faire du SSO 
	- Logiciel à installer sur certains serveurs de la topologie. 
	- Permet à un FortiGate de récupérer les identifiants des utilisateurs de manière passive. 
		- Sans leur demander directement leurs identifiants via un prompt. 
	- Quel agent faut-il installer et où? 
		- Le mode de déploiement du SSO et (le ou) les agents à installer et dépendent du type de serveur d'authentification. 

### Mode de déploiement du SSO avec Novell eDirectory 
- eDirectory agent mode 
	- Fonctionne sensiblement comme l'agent collecteur sur un DC Windows AD.

### Les modes de déploiement du SSO avec Windows AD 
1. Domain Controler agent mode 
	- Nécessite un agent (DC agent) sur chaque contrôleur du domaine ainsi qu'au moins un agent collecteur. 
	- Nécessite un redémarrage après l'installation des agents. 
2. Polling mode 
	- Ce mode permet le SSO lorsqu'il n'est pas possible d'installer un agent sur les DC. 
		- Ce mode génère plus de trafic.
	- Deux options : 
		- Soit avec un agent collecteur (Collector agent) installé sur un serveur du domaine. 
		- Soit sans agent (agentless).
3. Terminal Server agent mode 
	- Utilise un agent collecteur (TS agent) ou un Fortiauthenticator. 
	- Utilisé exclusivement pour les environnements Citrix et Terminal Services.

### Domain Controler agent mode 
- DC agent 
	- Nécessite un agent (DC agent) installé sur chaque contrôleur du domaine 
		- Sous forme de dll dans Windows\system32\dcagent.dll 
		- Un redémarrage est nécessaire après l'installation de l'agent. 
	- L'agent DC surveille les connexion des utilisateurs sur le DC 
		- L'agent DC envoie les informations de connexion à l'agent collecteur. 
		- Effectue les résolutions DNS pour connaitre les IP des utilisateurs. 
- Collector agent 
	- Nécessite au moins un agent collecteur sur un serveur Windows membre du domaine. 
	- L'agent collecteur est chargé de : 
		- Vérifier les groupes d'utilisateurs. 
		- Vérifier les stations de travail (workstation check). 
			» Refait les résolutions DNS au cas ou des IP auraient changé. 
		- Envoyer les informations de connexion mises à jour vers les FortiGates.

### Principe du "DC Agent Mode" 
- Le mode agent DC est le mode le plus évolutif
![[Pasted image 20241104143820.png]]

### Collector Agent-based Polling Mode 
- Collector agent 
	- Nécessite au moins un agent collecteur 
		- Sur un serveur Windows membre du domaine. 
	- Aucun agent DC n'est requis 
		- Pas besoin de redémarrer les DC. 
		- Pas besoin de maintenir à jour les agents DC. 
- Polling 
	- L'agent collecteur questionne chaque DC régulièrement sur les évènements de connexion 
		- Génère du trafic (parfois inutile si aucun utilisateur ne se connecte) 
		- Par défaut via SMB (TCP 445) 
		- Sinon via TCP 135, TCP 139, and UDP 137 
	- Trois méthodes de polling 
		- WMI, WinSecLog, NetAPI

### Event log polling using WMI 
- Windows Management Instrumentation (WMI) 
	- WMI est une API Windows 
		- Permet d'obtenir des informations système d'un serveur Windows. 
		- L'agent collecteur joue le rôle de client WMI et envoie des requêtes au DC qui agit en tant que Serveur WMI. 
- Caractéristiques 
	- Ne renvoie que les événements de connexion demandés 
		- Le collecteur ne doit pas rechercher les événements de connexion parmi tous les logs. 
		- Le journal des événements (Event Log) doit être activé. 
	- Utilisation de BP optimisée entre l'agent collecteur et le DC

### Event log polling (WinSecLog) 
- Le collecteur interroge le journal des événements des DC 
	- Le journal des événements (Event Log) doit donc être activé. 
- Caractéristiques 
	- Méthode plus lente 
		- Car il faut aller lire des journaux d'événements plutôt que des tables en RAM. 
	- Aucun événement de connexion n'est manqué, même en cas de forte charge. 
		- Car les logs ne sont généralement pas supprimés (rapidement). 
	- Latence possible 
		- Attention dans les grands réseaux ou en cas de lenteurs des systèmes.
		-  Nécessite des liens réseau rapides. 
	- Méthode requise pour les clients Mac OS qui se connectent à l'AD

### NetAPI polling 
- Le collecteur interroge la fonction NetSessionEnum 
	- Le collecteur récupère les informations de sessions établies sur un serveur DC via des requêtes envoyées à la fonction Windows NetSessionEnum. 
- Caractéristiques 
	- Méthode la plus rapide. 
	- Interroge la table des sessions en RAM 
		- Les sessions peuvent être rapidement créées et purgées de la RAM, avant que l'agent n'ait la possibilité d'interroger et de notifier les pare-feux. 
		- Il est donc possible de rater certaines ouvertures de sessions utilisateur en cas de forte charge du serveur AD ou du réseau.

### Principe du "Collector Agent-based Polling Mode" 
- Le collecteur doit régulièrement envoyer des requêtes au DC 
	- Pour connaître les événements de connexion (login events).
![[Pasted image 20241104144641.png]]

### Agentless polling mode 
- Le Fortigate envoie lui-même les requêtes au DC 
	- Aucun agent n'est utilisé. 
	- Le Fortigate interroge directement les logs des DC (WinSecLog) via SMB. 
- Caractéristiques 
	- Event log doit être activé 
		- Le Fortigate interroge le journal des événements du DC, celui-ci doit donc être activé. 
	-  Consomme les ressources du pare-feu 
		- Le Fortigate nécessite des ressources système (CPU, RAM) plus importantes car il collecte et traite toutes les données lui-même. 
	- Certaines fonctionnalités ne sont pas disponibles 
		- Notamment la vérification des stations de travail (workstation check).

### Principe du "Agentless Polling Mode" 
- N'utilise aucun agent 
	- Le Fortigate contacte lui-même les DC pour collecter les informations.
![[Pasted image 20241104150619.png]]

### Remarques (Quelle que soit la méthode) 
- Serveur DNS 
	- Event log fourni le nom d’hôte mais pas l'IP 
		- Les événements de connexion permettent d'obtenir le nom d'utilisateur et le nom de la station de travail mais pas l'adresse IP. 
	- Il est nécessaire de disposer de son propre serveur DNS 
		- Car si l'adresse IP d'un poste de travail change, les enregistrements DNS doivent être mis à jour immédiatement. 
- Connectivité avec les postes de travail 
	- La déconnexion d'un utilisateur ne génère pas d'entrée dans le journal des événements 
		- Chaque poste de travail utilisateur doit donc être régulièrement interrogé pour voir s’ils sont toujours là. 
	- Les agents collecteurs doivent donc pouvoir contacter les postes de travail 
		- Les ports TCP 139 et 445 doivent être ouverts entre les agents collecteurs/FortiGate et tous les hôtes. 
		- "Remote registry service" doit s'exécuter sur chaque poste de travail.

### Authentication FSSO via NTLM 
- NT Lan Manager (NTLM) 
	- Suite de protocoles de sécurité propriétaire de Microsoft 
		- FortiGate utilise NTML pour authentifier les utilisateurs via le navigateur web du client. 
		- Le navigateur Web doit donc supporter l'authentification NTLM. 
	- Solution non transparente pour les utilisateurs 
		- Les utilisateurs devront entrer leurs identifiants (Exception de IE). 
- Utilisations 
	- Dans des configurations de domaine simple, NTLM n'exige pas d'agents DC 
		- Solution souvent utilisée en backup du FSSO DC agent mode. 
			» Si le collecteur ne peut pas retrouver des utilisateurs connectés à un AD (par exemple lors d'un problème de communication entre un DC et un collecteur). 
			» FortiGate lance alors la négociation NTLM avec le navigateur du client pour les utilisateurs FSSO non actifs. 
	-  La solution peut être utile dans des configurations de domaine complexes 
		- En présence de multiples domaines elle ne nécessite qu'un seul agent collecteur global.
### Principe de l'authentication via NTLM 
1. L'utilisateur tente d'accéder à Internet avec son navigateur. 
2. Vérification si l'adresse IP figure dans la liste des utilisateurs actifs du FSSO. 
3. Si non, FortiGate utilise NTLM pour demander les identifiants de l'utilisateur. 
4. Le navigateur de l'utilisateur envoie les identifiants au FortiGate. 
5. FortiGate vérifie les identifiants et l'appartenance à un groupe via un agent collecteur. 
6. Si l'identification est correcte, l'accès est accordé en fonction de l'appartenance à un groupe.
![[Pasted image 20241104151354.png]]

### Authentication NTLM transparente 
- Certains navigateurs peuvent être configuré pour envoyer automatiquement les informations d'authentification lorsqu'ils reçoivent une requête NTLM.
![[Pasted image 20241104151446.png]]

### Agentless polling mode
![[Pasted image 20241104151604.png]]

### Collector agent polling mode and DC agent mode
![[Pasted image 20241104151620.png]]

### Installation des agents FSSO
![[Pasted image 20241104151642.png]]

### Installation des agents "DC"
![[Pasted image 20241104151655.png]]

### Installation des agents "DC"
![[Pasted image 20241104151709.png]]

### Installation des agents "collector
![[Pasted image 20241104151723.png]]

### Configuration des agents collecteur
![[Pasted image 20241104151735.png]]

### Configuration des minuteurs (collecteur)
- Workstation verify interval 
	- Intervalle de temps entre deux vérifications (si un utilisateur est toujours connecté). 
	- Par défaut : 5 minutes. 
	- Désactivation : régler la valeur sur 0. 
	- Le statut de l'utilisateur devient "not verified" si le collecteur ne peut pas se connecter au poste de travail pour faire la vérification 
- IP address change verify interval 
	- Vérifie les IP et met à jour le FortiGate lorsque les adresses IP des utilisateurs changent (Environnement DHCP). 
		- Le serveur DNS doit mettre à jour rapidement les modifications d'IP en cas de modification d'IP. 
	- Par défaut = 60 secondes.
- Dead entry timeout 
	- Si le statut est not verified, ce timer démarre. 
	- Utilisé pour purger les informations de connexion non vérifiée. 
		- Pour un Fortigate, toutes les entrées sont valides (vérifiée ou non). 
	- Par défaut : 480 minutes (8h). 
	- Désactivation : régler la valeur sur 0 → Le statut est toujours log on. 
- Cache users group 
	- L'agent collecteur met en cache l'appartenance à un groupe d'utilisateurs pendant une période de temps définie. 
	- Pendant cette période, il n'est pas mis à jour, même si l'utilisateur change de groupe dans l'AD.

### Configuration des filtres de groupe (collecteur) 
- Permet de définir quelles informations de connexion sont envoyées à quel FW • Surveiller trop d'informations (grande structure AD) est inefficace et consomme des ressources.
![[Pasted image 20241104153606.png]]
![[Pasted image 20241104153619.png]]

### Ignored User List 
- Les événements de connexion qui correspondent aux entrées de cette liste ne sont pas enregistrés par l'agent collecteur. 
	- Par exemple, il est intéressant d'y ajouter les comptes des services réseau.
![[Pasted image 20241104153711.png]]

### AD Group Support 
- Tous les types de groupes ne sont pas pris en charge, les groupes supportés pour le filtrage sont : 
	- Les groupes de sécurité (Security groups). 
	- Les groupes universels (Universal groups). 
	- Les groupes à l'intérieur des unités d'organisation (OU). 
	- Les groupes locaux ou universels qui contiennent des groupes universels de domaines enfants (uniquement avec le catalogue global). 
- Utilisateurs ne faisant pas partie d'un groupe d'utilisateurs FSSO 
	- Authentification passive uniquement 
		- Tous les utilisateurs qui n'appartiennent à aucun groupe FSSO sont automatiquement inclus dans le groupe d'invités SSO_guest_user (créé par défaut). 
	- Authentifications active et passive activées 
		- Les utilisateurs qui n'appartiennent à aucun groupe FSSO seront invités à entrer leurs identifiants.

### AD Access Mode Configuration 
- Permet de définir comment l'agent collecteur accède et recueille l'information sur les utilisateurs et les groupes d'utilisateurs.
![[Pasted image 20241104154014.png]]

### Journalisation des événements FSSO 
- Les logs liés au FSSO sont générés à partir des événements d'authentification.
![[Pasted image 20241104154036.png]]

### Configuration des logs au niveau du collecteur
![[Pasted image 20241104154052.png]]

### Affichage des utilisateurs "FSSO" connectés
![[Pasted image 20241104154108.png]]
![[Pasted image 20241104154203.png]]

### Vérifier la connectivité entre agents collecteurs et FortiGate
![[Pasted image 20241104154217.png]]

### Vérifier l'état du « polling » fait par le Fortigate (agentless mode)
![[Pasted image 20241104154248.png]]
