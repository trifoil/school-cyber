#Cybersec_2_index 
[[Cybersec_2_index]]
___

### Rappel IPsec
- Suite de protocoles utilisés pour sécuriser des communications IP
	- Objectifs : authentification, chiffrement, intégrité, anti-rejeu
		- Internet Key Exchange (IKE, UDP port 500). 
		- Échanges Diffie-Hellman (DH group). 
		- Encapsulation Security Payload (ESP). 
		- keyed-hash message authentication code
- NAT Traversal
	- Permet d’utiliser des VPN en présence de NAT et PAT. 
	- ESP est encapsulé dans UDP port 4500
- VPN
	- Route-based (tunnel L2TP, tunnel GRE, routage). 
	- Policy-based (FortiGate en mode transparent)

### Types de pairs distants
- Static IP Address
	- Utilisé lorsque l'adresse IP du pair distant est connue et ne changera pas. 
	- Le FortiGate peut être l'initiateur du tunnel VPN ou le répondeur.
- Dynamic DNS
	- Le pair distant a une IP dynamique, mais son domaine DNS est statique. 
	- Un DNS dynamique est utilisé pour résoudre l'IP la rendant ainsi prévisible. 
	- Le FortiGate peut être l'initiateur du tunnel VPN ou le répondeur.
- Dialup
	- Utilisé lorsque l'adresse IP du pair est dynamique et qu'il n'est pas possible de la retrouver. 
	- Le FortiGate peut uniquement être répondeur
		- Il ne peut pas initier la communication car il ne saurait pas vers quelle IP diriger sa requête.

### 1. VPN de site à site
![[Pasted image 20240924171605.png]]

### 2. Dialup VPN
- Utilisé lorsque l'on ne sait pas avec quelle IP le pair distant se connectera
	- C'est notamment le cas des travailleurs mobiles (télétravailleurs, en déplacement, …) 
	- Point-à-multipoint : une configuration dialup VPN peut être utilisée pour plusieurs tunnels IPsec d’utilisateurs distant
	![[Pasted image 20240924171636.png]]

### 3. Hub and spoke
- Tous les clients se connectent via un équipement central appelé hub
	- Avantages 
		- La configuration VPN et les règles de pare-feu sont facilement gérées. 
		- Consommation minimales de ressources dans chaque agence : un seul tunnel suffit
	- Inconvénients 
		- Le FortiGate central (Hub) nécessite plus de puissance. 
		- Si le site central est éloigné (autre continent), la latence peut être importante. 
		- Si le FortiGate central tombe, plus personne ne sait communiquer → prévoir HA.
![[Pasted image 20240924172002.png]]


### 4. Full meshed
- Maillage complet
	- Tous les FortiGates sont reliés les uns aux autres.
- Avantages
	- Moins de latence. 
	- Excellente tolérance aux pannes. 
	- Le site central nécessite moins de BP
- Inconvénients
	- Consommation de ressources 
		- Chaque FortiGate nécessite autant de tunnels qu'il n'y a de FortiGates distants. 
	- Topologie la plus complexe 
		- Notamment au niveau du routage. 
	- Plus cher 
		- Nécessite du matériel plus puissant
![[Pasted image 20240924172010.png]]

### 5. Partial meshed
- Maillage partiel 
	- Chaque FortiGate n'a pas nécessairement besoin de communiquer avec tous les autres
- Caractéristiques
	- Nécessite moins de ressources qu'un maillage complet. 
	- Conserve une bonne latence par rapport à une topologie hub and spoke. 
	- La configuration reste plus complexe par rapport à une topologie hub and spoke
	![[Pasted image 20240925105330.png]]

- Récap
![[Pasted image 20240924172019.png]]

### Sans ADVPN
- Communication VPN entre spoke 1 et spoke 3.
![[Pasted image 20240924172043.png]]

### Avec ADVPN
- Négociation dynamique de VPN 
	- ADVPN est un protocole permettant de négocier dynamiquement et à la demande des tunnel VPN directs entre les sites secondaires (spokes).
	![[Pasted image 20240924172123.png]]

### ADVPN
- Avantages 
	- Utile dans une topologie Hub-and-spoke ou partial meshed : 
		- Offre les avantages d'une topologie à maillage complet. 
		- Offre les facilités de configuration et d'évolutivité d'un déploiement hub and spoke ou partial meshed
- Routage dynamique nécessaire 
	- ADVPN nécessite l'utilisation d'un protocole de routage pour que les spokes puissent apprendre les routes vers d'autres spokes sans devoir être préconfigurés.
- FortiOS 
	- Actuellement Auto-discovery VPN est uniquement supporté par IKEv1. 
	- Les spokes doivent avoir une IP routable à partir de n'importe quel autre spoke. 
		- Les périphériques derrière NAT sont supportés depuis la version 6 pour autant que les ports UDP 500 et 4500 soient ouverts. 
	- ADVPN est similaire mais non compatible avec DMVPN (Cisco)

### Étapes de configuration ADVPN
1. Ajouter aux FortiGates les configurations VPN 
	- De manière à construire une topologie hub and spoke ou partial meshed. 
	- Voir chapitre VPN IPsec
2. Activer ADVPN
	- auto-discovery-receiver sur les VPN des spokes 
	- auto-discovery-sender sur les VPN du hub qui vont vers les spokes. 
	- auto-discovery-forwarded sur les VPN du hub qui vont vers d'autres hub
3. Configurer le routage
	- Un routage dynamique est nécessaire afin que les spokes puissent apprendre les routes vers d'autres spokes après que les VPN dynamiques aient été négociés. 
	- Voir chapitre sur le routage.

### Exemple de configuration ADVPN
![[Pasted image 20240924172434.png]]
### Tolérance aux pannes
- Résilience
	- Selon la topologie, si un hub tombe en panne, tous les VPN pourraient tomber. 
	- Pour améliorer la tolérance aux pannes, il est possible de configurer plusieurs VPN entre deux passerelles VPN. 
	- Uniquement pris en charge par les VPN route-based.
- Topologie partiellement redondante
![[Pasted image 20240924172521.png]]
- Topologie totalement redondante
	- Les deux pairs terminent leurs VPN sur des ports physiques différents.
	![[Pasted image 20240924172554.png]]
	- Les deux pairs terminent leurs VPN sur des ports physiques différents et passent pas des FAI différents
	![[Pasted image 20240924172613.png]]

### Étapes de configuration de VPN redondants
1. Créer une IKE phase 1 en mode route-based pour chaque tunnel VPN
	- Activer l'option Dead peer detection à chaque extrémité du tunnel (necessaire)
2. Créer au moins une IKE phase 2 pour chaque phase 1
3. Ajouter au moins une route pour chaque VPN (route-based)
	- Routes statiques et/ou dynamiques. 
	- Utiliser la distance administrative, la priorité ou la métrique pour sélectionner les routes principales par rapport aux routes de sauvegarde
4. Configurez les règles de pare-feu pour chaque interface tunnel
	- Autoriser le trafic à la fois pour le VPN principal et le VPN de sauvegarde

### Configuration de VPN redondants avec SD-WAN
![[Pasted image 20240924173239.png]]

### Configuration d'un VPN d'accès à distance (Remote access)
- Les étapes sont identiques à celles pour un VPN de site à site
	- Configurer IKE phase 1 et IKE phase 2. 
	- Configurer les règles de pare-feu. 
	- Configurer le routage.
- Les paramètres de configuration sont différents sur les deux pairs
	- Contrairement à un VPN de site à site où les pairs ont des configurations miroirs.
- Seul le coté "client" peut initier le tunnel VPN
	![[Pasted image 20240924173337.png]]

### Configuration IKE phase 1 coté serveur
![[Pasted image 20240924173418.png]]

### Configuration IKE phase 2 coté serveur
![[Pasted image 20240924173435.png]]
- IKE Phase 2 Quick mode selectors (Coté serveur)
	- Local address: le sous-réseau coté serveur VPN. 
	- Remote address: 0.0.0.0/0 (permet de correspondre à n'importe quelle adresse client)
		![[Pasted image 20240924173517.png]]

### Configuration du routage (coté serveur)
- Pour les VPN en mode route, une route statique vers le sous-réseau du client est automatiquement ajoutée après l'établissement du VPN.
![[Pasted image 20240924173541.png]]
- Si add-route est activé (choix par défaut) et le pair distant est de type “Dialup User”
	- Inutile de configurer une route statique. 
	- A la fin de IKE phase 2 FortiGate ajoute automatiquement une route statique ayant comme destination le réseau local présenté par le pair distant.
- Si add-route est désactivé
	- Un protocole de routage dynamique doit être utilisé et se charge de la mise à jour des routes.
	![[Pasted image 20240924173625.png]]

### Configuration des règles de pare-feu
- Deux règles à configurer sur chaque équipement (1 par sens). 
- Utiliser l'interface virtuelle IPsec (ToRemote dans l’exemple).
![[Pasted image 20240924173703.png]]

### Configuration d'un Dialup VPN coté serveur avec le wizard
- Assistant de configuration facilitant la configuration de VPN. 
- Pratique si tous les clients sont des FortClients
![[Pasted image 20240924173731.png]]

### Configuration IKE phase 1 coté client (client FortiGate
![[Pasted image 20240924173750.png]]
- IKE phase 2 Quick mode selectors (coté client)
	- Local address : le sous-réseau du client VPN. 
	- Remote address : le sous-réseau du serveur
		![[Pasted image 20240924173815.png]]
- Configuration du routage (coté client)
	- Une route statique vers le réseau du serveur doit être ajoutée manuellement.
		![[Pasted image 20240924173840.png]]

### Configuration IKE phase 1 coté client (client FortiClient)
![[Pasted image 20240924173904.png]]

### Accélération matérielle

- Possible selon le modèle de pare-feu
	- Certains modèles permettent le déchargement des opérations de chiffrement et déchiffrement IPsec.
- Si elle est disponible, l'accélération matérielle est activée par défaut
	- Pour désactiver l'accélération matérielle :
		![[Pasted image 20240924173945.png]]

### Vérifier le déchargement dans le cas d'un VPN IPsec
![[Pasted image 20240924174004.png]]

### Journaliser les événements VPN
![[Pasted image 20240924174023.png]]
![[Pasted image 20240924174037.png]]
![[Pasted image 20240924174051.png]]

### Moniteur de tunnel IPsec
- Permet d'afficher les informations sur les tunnels actifs.
	![[Pasted image 20240924174114.png]]
	![[Pasted image 20240924174124.png]]

### Dépannage
- Interopérabilité
	- Certaines marques de périphériques ne supportent pas :
		- Le quick mode selectors configuré à 0.0.0.0.0/0 
		- Et/ou qui utilisent des sous-réseaux de tailles différentes.
	- Par conséquent, ces appareils nécessitent un SA différent (et une phase 2 différente) pour chaque paire de sous-réseaux locaux et distants protégés.
- Solution
	- Soit configurer une phase 2 différente pour chaque paire de sous-réseaux locaux et distants 
	- Soit définir une seule phase 2 et activer le sélecteur dynamique IKEv1 
		- Le sélecteur dynamique IKEv1 crée automatiquement une phase 2 à la demande.
		![[Pasted image 20240924174231.png]]

### Le tunnel ne se forme pas
- Vérifier les configurations
	- La plupart des problèmes de connexion sont dus à des erreurs de configuration. 
	- Vérifier que les paramètres sont cohérents au niveau des deux extrémités.
- IKE real time debug
	- Activer le débogage temps réel sur chaque extrémité du tunnel. 
	- Permet de voir les détails de négociation des phases 1 et 2.
	![[Pasted image 20240924174328.png]]

### Exemple de debug (phase 1)
![[Pasted image 20240924174352.png]]

### Exemple de debug (phase 2)
![[Pasted image 20240924174419.png]]