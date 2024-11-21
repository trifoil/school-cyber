#Cybersec_2_index 
[[Bac_3_Index]]
___
### Principe de la HA
- Haute disponibilité 
	- La HA relie et synchronise deux ou plusieurs appareils. 
	- Un des appareils doit être actif, les autres peuvent être actif ou passif. 
- FortiGate actif 
	- Le FortiGate qui traite le trafic. 
	- Il synchronise sa configuration avec les autres appareils. 
- FortiGate passif 
	- FortiGate qui ne traite pas le trafic. 
	- Il synchronise sa configuration sur celle d'un FortiGate primaire pour être prêt à traiter le trafic dans le cas ou le primaire a un problème. 
- Heartbeat link 
	- Liens (UTP RJ45) reliant tous les appareils participant à la HA. 
	- Utilisé pour détecter les appareils qui ne répondent plus

### Topologie HA
![[Pasted image 20241016072953.png]]

### Mode actif-passif 
- FortiGate primaire 
	- Diffuse des paquets Hello pour la découverte et la surveillance. 
	- Le FortiGate qui agit en tant qu'appareil primaire synchronise sa configuration avec les autres appareils. 
	- Seul le primaire traite le trafic, il est actif. 
	- Si le primaire est redémarré ou éteint, il devient un FortiGate secondaire et attend que le trafic soit redirigé vers le nouveau primaire avant de s’éteindre. 
- FortiGate secondaire 
	- Diffuse des paquets Hello pour la découverte et la surveillance. 
	- Il synchronise sa configuration sur celle d'un FortiGate primaire. 
	- Il peut y avoir plusieurs secondaires. 
	- Il surveille l'état du primaire (paquet Hello reçu du primaire?).
		- Si le primaire ne « répond » plus, un secondaire reprend le rôle de primaire et traite le trafic. 
		- On parle alors de HA failover (basculement)

### Mode actif-actif 
- FortiGate primaire 
	- Il synchronise sa configuration avec les autres appareils. 
	- Le primaire traite le trafic, il est actif. 
	- Le primaire a la charge d'équilibrer le trafic entre tous les dispositifs du cluster HA. 
- FortiGate secondaire 
	- Tous les FortiGate secondaires traitent le trafic, ils sont aussi actifs. 
	- Ils surveillent l'état du primaire. 
		- Si le primaire a un problème, un des secondaires reprend le rôle de primaire. 
		- On parle alors de HA failover (basculement).

### FGCP 
- FGCP fonctionne uniquement sur les liens Heartbeat et est utilisé pour : 
	- Découvrir des FortiGates qui appartiennent au même groupe HA. 
	- Élire le primaire. 
	- Synchroniser les configurations et d'autres données. • Détecter la défaillance d'un FortiGate. 
- EtherType et ports utilisés 
	- Découverte des membres via diffusion sur les liens heartbeat (En mode NAT, le champ type Ethernet = 0x8890. En mode transparent, EtherType = 0x8891) 
	- Si le cluster fonctionne en mode actif-actif, le premier paquet d'une session distribuée au secondaire est encapsulé dans des trames Ethernet de type 8891 
	- Pour la synchronisation des données, la gestion locale de la CLI et la journalisation, les membres échangent des Ethernet trames de type 8893 . 
	- Selon le type de données à synchroniser, le port TCP 703 ou le port UDP 703, est utilisé pour la synchronisation des données. 
	- Le primaire relaie les journaux et les courriels d'alerte des secondaires sur le port TCP 700.

### Conditions requise pour la HA 
1. De deux à quatre FortiGates avec les mêmes : 
	- Firmware. 
	- Modèle pour le matériel et même licence pour les VM. 
	- Licenses FortiGuard, FortiCloud, and FortiClient. 
	- Capacité du disque dur et partitions. 
	- Mode de fonctionnement (transparent ou NAT). 
2. Au moins une liaison entre les appareils FortiGate 
	- Pour la communication HA (Heartbeat traffic). 
	- Pour la redondance, jusqu'à huit interfaces Heartbeat peuvent être utilisées. 
		- Si un lien échoue, HA utilisera le suivant, selon la priorité et la position dans la liste des interfaces Heartbeat. 
3. Mêmes interfaces connectées aux mêmes domaines de diffusion 
	- Les mêmes interfaces sur chaque appareil FortiGate doivent être connectées au même commutateur ou segment de réseau local (voir diapositive suivante).
	![[Pasted image 20241016073533.png]]

### Remarques 
- Adressage dynamique 
	- Depuis FortiOS 5.2, la HA supporte les interfaces dont les adresses IP sont assignées dynamiquement (DHCP ou PPPoE). 
	- Pour éviter des problèmes d'attribution d'adresses, il est recommandé de 
		1. Configurer le cluster avec des IP statiques. 
		2. Configurer l'adressage dynamique des interfaces uniquement lorsque le cluster HA est formé. 
- Licences différentes 
	- Si les membres du cluster n'ont pas les mêmes licences, le cluster s'aligne sur la "licence la plus faible". 
	- Par exemple, si un des FortiGates n'a pas de licence Antivirus, l'ensemble du cluster fonctionnera sans licence antivirus.

### Processus d'élection du FortiGate primaire 
1.  Avec le paramètre "HA override" désactivé
	![[Pasted image 20241016073740.png]]

2. Avec le paramètre "HA override" activé 
	- La priorité est prise en compte avant le temps de fonctionnement du système. 
		- Permet de configurer la priorité pour favoriser l'élection d'un FortiGate. •
- Conséquence sur le basculement HA 
	- Le basculement se produit lorsque le primaire tombe en panne (cas normal). 
	- Se produit aussi lorsque l'ancien primaire redevient disponible (à cause de sa priorité).
- Ordre des critères de sélection
	![[Pasted image 20241016073910.png]]
- Modifier le primaire si "HA override" est activé 
	- Il est possible de forcer manuellement le basculement (HA failover) en modifiant le priorité d'un FortiGate.

### Remarques 
- Synchronisation 
	- Les paramètres "override" et "priority" ne sont pas synchronisés au sein du cluster, ils doivent être ajustés manuellement sur chaque FortiGate. 
- Afficher les temps de fonctionnement des membres du cluster HA
![[Pasted image 20241016074029.png]]

### Rôles du primaire 
- Découvrir et surveiller les membres du cluster 
	- Échanges de paquets "heartbeat hello" avec tous les secondaires. 
	- Permet de découvrir des FortiGates ou vérifier que les FortiGates sont toujours présents dans le cluster HA. 
- Synchronisation 
	- Le primaire synchronise sa table de routage et une partie de sa configuration avec tous les secondaires. 
	- Le primaire peut être configuré pour synchroniser certaines informations de sessions de trafic pour un basculement en douceur. (voir plus loin) 
- En mode actif-actif 
	- Le primaire réparti le trafic entre tous les périphériques du cluster.

### Rôles des secondaires 
- Surveillance du primaire 
	- Surveille les ports et les paquets hello du primaire pour déceler des signes de défaillance.
	- Si un problème est détecté avec le primaire, les secondaires élisent un nouveau primaire et surveillent ce nouveau primaire. 
- Traitement du trafic distribué par le primaire 
	- En mode actif-actif uniquement.

### Adresses IP des interfaces "Heartbeat" 
- Le cluster assigne automatiquement des IP virtuelles aux interfaces Heartbeat 
	- Les adresses sont distribuées en fonction du N° de série de chaque FortiGate 
		- 169.254.0.1 : pour le numéro de série le plus élevé. 
		- 169.254.0.2 : pour le deuxième numéro de série le plus élevé. 
		- 169.254.0.3 : pour le troisième numéro de série le plus élevé 
		- Etc. 
	- Ces IP sont utilisées pour distinguer les membres du cluster et synchroniser les données 
- Modification de l'adresse IP virtuelle Heartbeat 
	- Les FortiGates conservent leurs adresses IP virtuelles Heartbeat 
		- Peu importe leur rôle (primaire ou secondaire). 
		- Peu importe s'il y a basculement (primaire vers secondaire ou secondaire vers primaire). 
	- Les FortiGates changent d'adresses IP virtuelles Heartbeat 
		- Uniquement lorsqu'un FortiGate quitte ou rejoint le cluster. 
		- Le cluster renégocie alors l'attribution de l'adresse IP Heartbeat en tenant compte du numéro de série de tout nouveau périphérique.

### Les ports "Heartbeat" 
- Le trafic heartbeat est important pour le bon fonctionnement du cluster 
	- Il est nécessaire de disposer d'une BP suffisante 
		- Permet de garantir que les configurations du cluster sont dans un état synchronisé à tout moment. 
	- Si un switch est présent entre deux FortiGates 
		- Il doit être dédié et isolé du reste du réseau. 
		- Ainsi, FGCP n'est pas concurrencé par d'autres trafics pour l'utilisation de la BP. 
- Interfaces physiques routées requises 
	- La communication Heartbeat est activée sur les interfaces physiques routées
		- Pas sur les sous-interfaces VLAN, les interfaces VPN IPsec, les interfaces redondantes, les interfaces agrégées 802.3ad ou les ports "switchés" du FortiGate.

### Les ports monitorés 
- Un cluster HA peut être configuré pour surveiller l'état des liens de certaines interfaces 
	- Les ports surveillés sont généralement des interfaces réseaux traitant un trafic hautement prioritaire. 
	- Les interfaces physique, VLAN et les LAG peuvent être monitorées. 
		» Rappel LAG = Link Aggregation Group (= Etherchannel)
-  Basculement nécessaire ? 
	- Éviter de configurer la surveillance pour toutes les interfaces 
		- Vous ne devez configurer la surveillance d'interface que pour les ports dont la défaillance doit déclencher un basculement de périphérique. 
		- Notamment, ne surveillez pas les interfaces heartbeat.

### Synchronisation complète
1) Un secondaire est ajouté au cluster. 
2) Le primaire compare la somme de contrôle de sa configuration avec celle du secondaire. 
3) Si elles sont différentes, le primaire envoie sa configuration au secondaire.
![[Pasted image 20241016074615.png]]

### Synchronisation incrémentale 
- Est utilisée lorsque la synchronisation initiale (complète) est terminée. 
- Le primaire enverra tout changement de configuration à tous les secondaires. 
	- Seules les modifications sont envoyées.
![[Pasted image 20241016083255.png]]

### Caractéristiques de la synchronisation incrémentale 
- Quelles informations sont synchronisées ? 
	- Les configurations mais aussi d'autres données telles que la table de routage, les baux DHCP, les SA IPsec, les tables ARP, … 
	- Les sessions peuvent être synchronisées (désactivé par défaut). 
- Vérifications périodiques 
	- Par défaut, le primaire vérifie toutes les 60 secondes que tous les périphériques sont synchronisés 
		- Si l'un des secondaires n'est pas synchronisé, le checksum des secondaires est vérifié toutes les 15 secondes. 
		- Si le checksum ne correspond pas pour cinq contrôles consécutifs, une re- synchronisation complète est effectuée.

### Session Synchronization 
- La synchronisation des sessions permet un basculement en douceur 
	- Les informations de sessions étant synchronisées, les sessions peuvent rester ouvertes. 
		- Le nouveau primaire peut prendre le relais là où les sessions en étaient arrivées. 
	- Le trafic peut être interrompu pendant un court instant lors du basculement 
		- Cependant, les applications n'ont pas besoin de reconnecter les sessions à nouveau. 
- Uniquement possible pour certains types de trafic 
	- Les sessions TCP et IPsec VPN qui ne sont pas traitées par une inspection en mode proxy 
		- Exception : les sessions SIP peuvent être synchronisées même en mode proxy. 
	- La commande set session-pickup permet d'activer la synchronisation des sessions TCP
			![[Pasted image 20241016084906.png]]
- Il est possible d'activer la synchronisation des sessions UDP et ICMP 
	- Bien que les deux protocoles soient sans session 
		- Des entrées sont créées dans la table de session FortiGate pour chaque flux de trafic UDP et ICMP. 
	- Généralement pas nécessaire 
		- La plupart des applications réseau basées sur UDP ou ICMP sont capables de garder la communication même lorsque leurs informations de session sont perdues.
		![[Pasted image 20241016084939.png]]

### Éléments non synchronisés 
- Tous les paramètres de configuration ne sont pas synchronisés, c'est notamment de cas : 
	- Des paramètres de l'interface de gestion du HA. 
	- Du paramètre "HA override". 
	- De la priorité HA du FortiGate. 
	- De la priorité du cluster virtuel. 
	- Du nom d'hôte. 
	- Des licences. 
		- Les licences FortiToken (numéros de series) sont synchronisés. 
	- Des caches (Filtrage Web, Email, …). 
	- Des priorités HA du "ping server" (permettant la détection de passerelles en panne).

### Causes de basculement et de journalisation 
- Dead member (Membre mort) 
	- Le basculement est déclenché lorsque le FortiGate primaire cesse d'envoyer du trafic heartbeat. 
- Failed link (Liaison défaillante) 
	- Le basculement est déclenché lorsque l'état d'une interface surveillée sur le FortiGate primaire tombe en panne. 
	- Seules les interfaces physique, redondante et LAG peuvent être surveillées. 
- Failed remote link (Lien distant défaillant) 
	- Le FortiGate utilise la fonction de surveillance de l'état des liens (LHM) pour surveiller l'état d'une ou de plusieurs interfaces. 
	- Le FortiGate primaire est considéré comme défaillant si la pénalité cumulée de toutes les interfaces défaillantes atteint le seuil fixé.
	![[Pasted image 20241016104205.png]]

### Configuration du basculement 
- Memory-based (Basé sur l’utilisation de la mémoire) 
	- Un seuil d’utilisation de la mémoire peut être configuré. Lorsque ce seuil est dépassé pendant le laps de temps défini, il y a basculement. 
- Failed SSD (SSD défaillant) 
	- Le basculement est déclenché lorsque le FortiOS détecte une défaillance dans un SSD. 
	- Uniquement disponible pour les appareils équipés de disques SSD. 
- Admin-triggered (déclenché par l'administrateur) 
	- Le basculement est déclenché manuellement par l'administrateur. 
- Remarque 
	- Lorsqu'un basculement se produit, un fichier journal est généré. 
	- Le Fortigate peut également générer un trap SNMP et un email d'alerte.
	![[Pasted image 20241016104316.png]]

### Causes de basculement et de journalisation 
- Device failover (dead member) 
	- Ce type de basculement est toujours actif.
	![[Pasted image 20241016104347.png]]

### Causes de basculement et de journalisation 
- Remote link failover (Failed link ) 
	- Configurer le Link Health Monitor (voir chapitre sur le routage)
	![[Pasted image 20241016104435.png]]
- Configurer les paramètres HA relatifs à la défaillance de lien
![[Pasted image 20241016104457.png]]

### Causes de basculement et de journalisation 
- Memory-based failover (Utilisation élevée de la mémoire) 
	- Un seuil d’utilisation de la mémoire peut être configuré. Lorsque ce seuil est dépassé pendant le laps de temps défini, il y a basculement.
	![[Pasted image 20241016104533.png]]

### Adresses MAC virtuelles et basculement 
- Pour transférer le trafic, la HA utilise des adresses MAC virtuelles 
	- Assignation automatique d'une adresse MAC virtuelle 
		- Lorsqu'un primaire rejoint un cluster HA, une adresse MAC virtuelle est assignée à chacune de ses interfaces (hormis les interfaces heartbeat). 
	- Le primaire informe tous les secondaires de l'adresse MAC virtuelle assignée 
		- Via les liens heartbeat. 
- En cas de basculement 
	- L'adresse MAC virtuelle du FortiGate actif ne change pas 
		- Lors du basculement, le secondaire qui devient le nouveau primaire adopte les mêmes adresses MAC virtuelles que l'ancien primaire pour les interfaces équivalentes. 
	- Le nouveau primaire informe tous les secondaires 
		- Après le basculement, le nouveau primaire informe, via des paquets gratuitous ARP, que chaque adresse MAC virtuelle est désormais accessible via un autre chemin

### Panne d'un secondaire 
- Dans un cluster actif-passif 
	- Le primaire met à jour la liste les FortiGates secondaires disponibles. 
	- Le primaire surveille le secondaire défaillant en attendant qu'il soit de nouveau opérationnel. 
- Dans un cluster actif-actif 
	- Tous les secondaires gèrent aussi le trafic 
		- Le primaire suit et assigne des sessions à chaque secondaire. 
	- En cas de défaillance d'un secondaire 
		- Le primaire doit également réassigner les sessions du FortiGate défaillant à un autre FortiGate secondaire. 
		- Le primaire surveille le secondaire défaillant en attendant qu'il soit de nouveau opérationnel.

### Répartition de la charge en mode actif – actif 
- Le client envoie un paquet SYN au FortiGate primaire 
	- Il utilise l'adresse MAC virtuelle de l'interface interne comme destination. 
- Le primaire décide si la session sera traitée par un secondaire 
	- Si oui, il transmet le paquet SYN au secondaire qui effectuera les inspections. 
	- Le primaire utilise l'adresse MAC physique du FortiGate secondaire comme adresse de destination. 
	- Par défaut, seule les session en mode proxy sont envoyées à un secondaire. 
		- L’option load-balance-all permet de distribuer n’importe quelle session. 
- Le secondaire traite la session 
	- Le secondaire répond avec un SYN/ACK au client. 
	- Le secondaire démarre la connexion avec le serveur (auquel le client souhaite se connecter) en lui envoyant directement un paquet SYN.
1) Le client envoie un paquet SYN au FortiGate primaire 
	- Dest MAC aaaa.aaaa.aaaa, src MAC eeee.eeee.eeee, TCP SYN dport 80 
2) Le primaire décide si la session sera traitée par un secondaire 
	- Si oui, il transmet le paquet SYN au secondaire qui effectuera les inspections. • Dest MAC bbbb.2222.2222, src MAC aaaa.1111.1111, TCP SYN dport 80
	![[Pasted image 20241016105306.png]]
3) Le secondaire traite la session 
	1. Le secondaire répond avec un SYN/ACK au client. 
		- Dest MAC eeee.eeee.eeee, src MAC bbbb.2222.2222, TCP ACK sport 80. 
	2. Le secondaire démarre la connexion avec le serveur 
		- Dest 4444.4444.4444, src cccc.3333.3333, TCP SYN dport 80. 
4) Le client envoie un paquet ACK au FortiGate primaire 
	- Dest aaaa.aaaa.aaaa, src eeee.eeee.eeee, TCP ACK dport 80. 
5) Le primaire transmet l'ACK au secondaire 
	- Dest bbbb.2222.2222, src aaaa.1111.1111, TCP ACK dport 80
![[Pasted image 20241016105520.png]]
6) Le serveur répond au primaire par un SYN/ACK 
	1. Dest MAC aaaa.aaaa.1111, src MAC 4444.4444.4444, TCP SYN ACK sport 80
7) Le primaire transmet le SYN/ACK au secondaire 
	- Dest cccc.3333.3333, src aaaa.1111.2222, TCP ACK sport 80.
8) Le secondaire accuse réception du SYN/ACK au serveur 
	- Dest 4444.4444.4444, src cccc.3333.3333, TCP ACK sport 80.
![[Pasted image 20241016105708.png]]

### Balancement de charge en mode actif-actif 
- Les sessions suivantes ne sont pas prise en charge par le balancement de charge 
	- ICMP, multicast, broadcast, SIP ALG, IM, P2P, IPsec VPN, SSL VPN, HTTP multiplexing, SSL offloading, WAN optimization, explicit web proxy, WCCP 
	- Les sessions HTTPS ne sont pas équilibrées en charge si elles font l'objet d'une inspection en mode proxy. 
		- La charge des sessions HTTPS est équilibrées uniquement lorsque load- balance-all est activé et le mode d'inspection est en mode flux ou lorsque le mode d'inspection est proxy et le trafic HTTPS n'est pas inspecté.

### Méthodes de balancement de charge en mode actif-actif 
- none 
	- Pas de balancement de charge, le primaire prend en charge toutes les sessions 
- leastconnection 
	- Le primaire distribue les sessions au secondaire en ayant le moins. 
- Round-robin 
	- Le primaire distribue les sessions à tour de rôle. 
- Weight-round-robin 
	- Le primaire distribue les sessions en fonction du poids de chaque membre du cluster. 
- Random 
	- Le primaire distribue les sessions aléatoirement 
- Iphub 
	- Les sessions ayant le même couple source/destination sont traitées par le même membre. 
- Ipport 
	- Les sessions sont distribuées en fonction des adresses et ports source/destination. Plus le trafic est varié, plus le trafic sera distribué parmi les membres.
- Configuration de la Méthodes de balancement de charge en mode actif-actif
![[Pasted image 20241016105928.png]]
- Configuration du poids (si round-robin)
	- A faire sur le primaire (pour chaque membre du cluster HA va se synchroniser)
	![[Pasted image 20241016110003.png]]
	-  Vous pouvez obtenir l’ID (index) du membre avec la commande get system ha status
	![[Pasted image 20241016110042.png]]

### Virtual clustering 
- Multiples VDOM
	- Lorsque plusieurs VDOM sont utilisés, il est possible de configurer des clusters virtuels. 
- Répartition de charge 
	- Chaque FortiGate peut agir à la fois comme primaire pour un VDOM d'un cluster et comme secondaire pour un autre VDOM d'un autre cluster. 
	- De cette manière, la charge de trafic est répartie entre les FortiGate des clusters. 
- Limitation 
	- Le clustering virtuel est réalisable uniquement entre deux FortiGate ayant plusieurs VDOM.
![[Pasted image 20241016110142.png]]

### Full mesh HA 
- Haute disponibilité avec maillage complet 
	- Topologie plus robuste 
		- Offre une tolérance aux pannes au niveau des commutateurs, des FortiGates et des interfaces des FortiGates (Pas de Single point of failure)
![[Pasted image 20241016110233.png]]
- Limitation 
	- Uniquement disponible sur le matériel haut de gamme.

### Firmware updates 
- Redémarrage nécessaire 
	- Comme pour une mise à jour classique, chaque FortiGate devra redémarrer. 
	- Seul le primaire doit être mis à jour. 
- Uninterruptable upgrade 
	- Le paramètre "Uninterruptable upgrade" est activé par défaut 
		- Cela implique que le cluster mettra d'abord à niveau les FortiGates secondaires. 
		- S'il est désactivé, tous les FortiGates se mettront à jour en même temps. 
			» L'opération est plus rapide, mais le trafic sera interrompu momentanément. 
	-  Élection d'un nouveau primaire 
		- Une fois que tous les FortiGates secondaires mis à jour, un nouveau primaire est élu et le firmware de l'ancien primaire est mis à niveau. 
- Cluster en mode actif - actif 
	-  L'équilibrage de la charge de trafic est temporairement désactivé pendant que tous les périphériques mettent à jour leur firmware.

### Se connecter à un membre du cluster 
- Via l’adresse IP virtuelle du cluster HA 
	- Dans ce cas, vous vous connectez toujours au FortiGate primaire. 
- Via une interface réseau (In-band HA management interface) 
	- Permet d’utiliser n’importe quelle interface
	![[Pasted image 20241016110651.png]]
- Configurer une interface réservée pour l’administration HA (Out-of-band) 
	- Consiste à utiliser une interface dédiée à l’administration du cluster (pas d’autres trafic via cette interface)
	![[Pasted image 20241016110723.png]]

### Vérifier le statut du cluster HA en GUI
![[Pasted image 20241016110739.png]]
- Un widget peut être ajouté dans le dashboard pour connaitre l'état du cluster
![[Pasted image 20241016110755.png]]
- Permet d'obtenir plus d'informations qu'en GUI
![[Pasted image 20241016110850.png]]
![[Pasted image 20241016110920.png]]

### érifier l'état de la synchronisation de la configuration 
- Si le primaire et le secondaire présentent les mêmes checksum, ils sont synchronisés
![[Pasted image 20241016111021.png]]

### Se connecter à un secondaire 
- La CLI d’un membre permet de se connecter à un autre membre
![[Pasted image 20241016111059.png]]
- Le point d'interrogation permet de lister les numéros d'index de chaque FortiGate
![[Pasted image 20241016111113.png]]

### Afficher ou recalculer les checksum
![[Pasted image 20241016111126.png]]

### Vérifier l'état de la synchronisation de la configuration
![[Pasted image 20241016111147.png]]

### Interfaces de management d'un cluster HA 
- Réserver une interface dédiée pour la gestion du cluster 
	- Il est possible de réserver une interface physique de gestion différente pour chaque appareil. 
		- Permet de se connecter en CLI et GUI directement à chaque FortiGate du cluster sans devoir se connecter via le primaire. 
		- Permet que chaque appareil envoie ses logs et son trafic SNMP indépendamment. 
	- La configuration de cette interface de gestion n'est pas synchronisée. 
	- Fonction disponible en mode NAT et en mode transparent. 
- Interface de gestion "In-band" 
	- Permet de se connecter directement à chaque FortiGate du cluster sans devoir se connecter via le primaire et sans devoir réserver une interface de gestion
		![[Pasted image 20241016111246.png]]