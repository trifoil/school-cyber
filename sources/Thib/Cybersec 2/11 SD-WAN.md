#Cybersec_2_index 
[[Bac_3_Index]]
___
### Solutions WAN
- PPP (Lignes louées) 
	- Utilisé pour fournir des communications point à point sur des lignes louées. 
	- Circuit préétabli et permanent. 
	- Bande passante fixe. 
	- Très cher.
		![[Pasted image 20241112073601.png]]
- ATM 
	- Partage des ressources (comme pour Frame Relay). 
	- Commutation de cellules de petite taille (53 octets). 
	- A permis d'augmenter les vitesses disponibles. 
	- Plus compliqué à déployer et à gérer. 
	- Reste cher
			![[Pasted image 20241112082111.png]]
- MPLS (Multiprotocol Label Switching) 496 
	- Très bien pour interconnecter des sites (central – agences/filiales) 
	- Performances fiables, QoS peut être garantie → Voix/vidéo OK. 
	- Assure un cloisonnement et une sécurité des flux informatiques internes à l’entreprise. 
	- Communication directe de site à site possible (Full/partial meshed). 
	- Nombreux supports utilisables (DSL, câble, sans fil, fibre, …). 
	- Reste cher, surtout si nombreux sites à interconnecter.
				![[Pasted image 20241112082244.png]]
- VPN IP 
	- Très bien pour interconnecter des sites (central – agences/filiales) 
	- Communication directe de site à site possible (Full meshed). 
	- Supporte de nombreux supports (E1, DSL, câble, sans fil, fibre optique). 
	- Best effort : Aucune garantie sur la qualité de service, vitesses variables. 
	- Beaucoup moins cher que MPLS. 
	- Sécurité faible (ligne Internet publique), nécessité d'une infrastructure de sécurité (Firewall, VPN, …).
![[Pasted image 20241112082348.png]]

### Les challenges d’un réseau WAN 
- Internet s'est développé vers le cloud 
	- Des entreprises n'utilisent plus certaines applications en local (SaaS) 
		- Office 365, skype for business, … 
	- Des entreprises hébergent leurs propres services dans le cloud (IaaS) 
		- Via AWS, Azure, … 
	- On veut accéder à ses applications de partout et à n'importe quel moment 
		- Internet devient incontournable. 
	→ Les applications et les infrastructures peuvent être situées n'importe où. 
	→ Les modèles de trafic ont changés et changent régulièrement, il faut pouvoir s'adapter rapidement. 
	→ Cela rend plus difficile de garantir de bonnes performances pour les utilisateurs.
- Certains services sont toujours en interne 
	- Par exemple un LAN et un Data Center sur site 
		- Dans une infrastructure traditionnelle, chaque périphérique a son propre control plane (QoS, Routage) et son propre data plane. 
	- Dans une infrastructure distribuées (Site central + filiales/agences) 
		- Dans les agences, on n’a généralement pas les moyens d'utiliser toutes les solutions de sécurité que l'on a mises en place dans le site central. 
		- Du coup on relie la filiale au site central via une ligne MPLS couteuse. 
	→ Pas de système centralisé d'approvisionnement.
- Routage 
	- Peut nécessiter plusieurs accès WAN 
		- Une ligne VPN IP vers Internet. 
		- Une ligne louée ou MPLS pour les données/business critique vers Internet. 
		- Une ligne 3G/4G en backup vers Internet. 
		- Des lignes MPLS pour relier les agences et site central. 
	- Le trafic est priorisé sur base des n° de port, donc des protocoles et pas en fonction des applications. 
	→Pas d'équilibrage de charge en fonction de l'application.
-  Qualité de service 
	- La QoS se base sur DSCP qui ne tient pas compte de la qualité de la ligne. 
	→ Pas de basculement dynamique en fonction de la qualité de la ligne

### Solution MPLS
![[Pasted image 20241112092225.png]]

### Solution MPLS + VPN IP
![[Pasted image 20241112093053.png]]

### Sans MPLS
![[Pasted image 20241112093118.png]]

### Software Defined Wide Area Network 
- SD-WAN c'est une surcouche au WAN qui agrège les dernières technologies au niveau des accès WAN 
	- Moteurs de reconnaissances applicatives 
		- Afin de pouvoir détecter les applications, les suivre et donner de la visibilité sur les performances. 
	- Routage applicatif 
		- Afin de router les donnés en fonction de l'application et de la performance des liens. 
		- Permet d'assurer les meilleures performances aux applications critiques. 
	- Solutions de performances applicatives 
		- Contrôle applicatif, compression, accélération TCP, … 
	- Découplage des plans de contrôle et de données de manière à 
		- Pouvoir gérer le data plane de plusieurs périphériques de manière centralisée. 
		- Pouvoir gérer le data plane de plusieurs périphériques depuis le cloud. 504 
	→ SD-WAN permet de 
	-  construire un réseau virtuel prenant appui sur un réseau physique, 
	- de le piloter depuis un point central.

### Interface SD-WAN 
- Interface virtuelle
	- Constituée d'un groupe d'interfaces membres 
		- Les interfaces membres peuvent être connectées à différents types de liens (Généralement connectées à plusieurs FAI). 
		- Prise en charge des interfaces physique, agrégées, VLAN et IPsec. 
	- Ces interfaces sont vues comme une seule interface logique appelée interface SD-WAN 
		- Une règle implicite est générée automatiquement pour équilibrer le trafic
![[Pasted image 20241112103810.png]]
-  Caractéristiques d'une interface SD-WAN 
	- Permet une utilisation efficace du WAN 
		- Différents algorithmes permettent d'équilibrer la charge en fonction de la BP, du nombre de sessions, de l'application, … 
	- Simplifie la configuration 
		- Permet de configurer un ensemble unique de routes et de règles de pare-feu qui seront appliquées à tous les FAI. 
	- Prend en charge la mesure de la qualité des liens 
		- Sélection dynamique des liens basée sur la qualité des liens. 
		- Assure une haute disponibilité des applications critiques pour l'entreprise
![[Pasted image 20241112104024.png]]

### Configuration
![[Pasted image 20241112104105.png]]

### Configuration de la méthode d'équilibrage de charge –
- Load-balance mode 
	- Le mode “load-balance” remplace le mode “v4-ecmp” lorsque le SD-WAN est activé. 	
1. Source IP (default) 
	- Les sessions d'une même adresse IP source utilisent la même interface. 
2.  Source-destination IP 
	- Les sessions avec la même paire IP source/destination utilisent la même interface. 
3. Spillover (Usage) 
	- La même route est utilisée jusqu'à ce qu'un seuil de volume de trafic (en kbps) soit atteint. Tout trafic au-delà de ce seuil est envoyé sur une autre interface. 
	- oad-balance-mode utilise les seuils de débordement définis dans la configuration du membre SD-WAN, v4-ecmp-mode les seuils de débordement définis dans les paramètres de l'interface.
			![[Pasted image 20241112104248.png]]
4. Weight 
	- Le trafic est distribués en fonction du poids de l'interface. 
	- « Load-balance-mode » utilise le poids défini dans la configuration du membre SD- WAN, v4-ecmp-mode le poids défini dans la route statique. 
		- Le poids est un nombre entier. 
5. Volume (Bandwidth) 
	- Le mode “load-balance” remplace le mode “v4-ecmp” lorsque le SD-WAN est activé. 
	- Dans ce mode, les sessions peuvent être distribuées de manière à répartir le volume de trafic en fonction du poids de l'interface
		![[Pasted image 20241112104401.png]]

### Zones SD-WAN 
- Plus petit groupement d’interfaces membre du SD-WAN 
	- Plusieurs interfaces membre du SD-WAN peuvent être regroupées en groupes logiques plus petits (appelés zones SD-WAN). 
	- Permet un contrôle plus granulaire du trafic inspecté et autorisé dans les règles de pare-feu. 
		- Les interfaces membres individuelles du SD-WAN ne peuvent pas être utilisés dans une règle de FW. . 
- Caractéristiques 
	- Une même interface membres du SD-WAN ne peut pas être partagées entre plusieurs zones. 
	- Par défaut, FortiGate a crée la zone « virtual-wan-link ». 
	- Les zones SD-WAN sont incluses dans la vue topologique de la Security Fabric

### Configuration de Zones SD-WAN
![[Pasted image 20241112104558.png]]

### Configuration des règles de FW –
- Configurer uniquement les règles avec l'interface SD-WAN 
	- Inutile de configurer des règles de pare-feu pour chaque interfaces membres.
			![[Pasted image 20241112104627.png]]

### Configuration du routage 
- Configuration d'une route par défaut utilisant l'interface SD-WAN 
	- Même si une seule route est configurée via l'interface SD-WAN, FortiGate installe des routes individuelles pour les interfaces membres dans la table de routage
![[Pasted image 20241112104917.png]]

### Performance SLA : LHM 
- Link Health Monitor (Link heakth check) 
	- Permet de détecter l'arrêt ou la dégradation d'un routeur le long du trajet. 
	- Vérifie le statut de chaque membre de l'interface SD-WAN.
![[Pasted image 20241112104955.png]]

### Performance SLA : Link Quality Measurement 
- Mesure également la qualité de la liaison de chaque interface membre
![[Pasted image 20241112105027.png]]

### Performance SLA : SLA Targets 
- SLA Targets 
	- Un lien membre SD-WAN affecté à un performance SLA doit satisfaire au SLA Targets afin d'être sélectionné parmi les autres liens participants
![[Pasted image 20241112105136.png]]
![[Pasted image 20241112105146.png]]
![[Pasted image 20241112105154.png]]

### SD-WAN Rules 
- Définissent quel trafic doit être acheminé à travers quelle interface membre
![[Pasted image 20241112105221.png]]
![[Pasted image 20241112105233.png]]
- Stratégie de sélection d'une interface de sortie 
	1. Manual 
		- Si le traffic correspond aux critères de correspondance, l'interface renseignée est utilisées. 
		- Ne tient pas comptes des éventuelles configurations de SLA targets
		![[Pasted image 20241112105307.png]]
- Stratégie de sélection d'une interface de sortie 
	2. Best Quality 
		- Se base sur la performance du reseau (health check) mais pas sur les SLA targets. 
		- La première interface listée est utilisée jusqu'à ce que les critères de qualité de ce réseau soient de 10% inférieurs à ceux de l'interface suivante
![[Pasted image 20241112105429.png]]
- Stratégie de sélection d'une interface de sortie 
	3. Lowest Cost (SLA)
![[Pasted image 20241112105502.png]]
![[Pasted image 20241112105538.png]]
![[Pasted image 20241112105603.png]]
- Application des règles 
	- Même principe que pour les règles d'un pare-feu 
		- Lecture séquentielle. 
		- La première correspondance est appliquée. 
	- Les règles SD-WAN sont traitées comme des policy-based routes 
		- Elles sont prioritaires par rapport aux routes de la table de routage
![[Pasted image 20241112105701.png]]

### SD-WAN Usage Monitor 
- Permet de voir la répartition du trafic entre les interfaces membres
![[Pasted image 20241112105728.png]]

### SD-WAN Link Status Monitoring 
- Le changement d'état d'un interface génère un log
![[Pasted image 20241112105926.png]]

### Vérifier le routage du traffic SD-WAN 
- Les logs permettent de vérifier par quelle interface membre le trafic est envoyé 
![[Pasted image 20241112110003.png]]
- Le sniffer intégré permet aussi de vérifier par quelle interface le trafic est envoyé
![[Pasted image 20241112110030.png]]
