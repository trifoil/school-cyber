#Cybersec_2_index 
[[Bac_3_Index]]
___
### Challenges 
- La surface d'attaque augmente avec le reseau de l’entreprise 
	- Cloud, Multicloud, IoT, télétravail, BYOD, … 
- La quantité et la vitesse des menaces continue d'augmenter 
	- Malware as a service, malware multi-vecteurs, … 
- La complexité augmente avec le reseau 
	- Gestion des accès et des dispositifs 
		- Fusion, acquisition, télétravailleurs, fournisseurs, … 
	- Nombre de solutions de sécurité 
		- Différentes solutions sont développées pour faire faces aux différentes attaques. 
		- Une entreprise peut utiliser plus de 70 solutions de sécurité pour faire face aux différentes attaques possibles. 
	- Normes et réglementation à respecter 
		- RGPD, ISO 27000, CIS, NIST, …

### Fortinet Security Fabric 
- Solution de sécurité offrant une approche globale et centralisée 533 
	- Les équipements ne sont pas isolés mais sont interconnectés et forment un tout. 
	- Permet d'avoir une vue d'ensemble de tous les points d'infiltration potentiels et de coordonner les défenses
		![[Pasted image 20241112111213.png]]

### Avantages 
- Automatisation des opérations de sécurité 
	- Diminue les risques notamment grâce à la détection proactive des menaces, à la corrélation des menaces et aux échanges d'alertes. 
- Gestion centralisée des périphériques 
	- Partage en temps réel des renseignements sur les menaces entre périphériques. 
- Couvre l'ensemble de la surface d'attaque du réseau. 
	- Tous les éléments de l'IoT jusqu'au cloud sont intégrés dans l'écosystème de sécurité. 
		→ Large visibilité sur l'ensemble du réseau. 
-  "Ouvert" 
	- Des API permettent l'intégration d'équipements d’autres fabricants. 
		- > 70 partenaires "Fabric-Ready". 
		- Des API REST et les scripts DevOps permettent aux clients d'ajouter les équipements non compatibles Fabric.

### Composants de la solution Fortinet Security Fabric
![[Pasted image 20241112111416.png]]
- Cœur de la solution 
	- Au minimum, il faut un FortiAnalyzer et au moins deux FortiGates. -
- Équipements recommandés pour améliorer la visibilité et le contrôle 
	- FortiManager, FortiAP, FortiSwitch, FortiClient, FortiSandbox, FortiMail. 
- Solution étendue 
	- Autres solutions Fortinet ou équipement tiers en fonction des besoins

### Exemple de déploiement
![[Pasted image 20241112111557.png]]

### Etapes de configuration de la solution Fortinet Security Fabric 
- Sur le FortiGate racine 
	- Activez la connexion « Security Fabric » sur les interfaces requises. 
	- Activez le connecteur « Security Fabric » et sélectionnez « Serve as Fabric Root ». 
	- Configurez FortiAnalyzer ou la journalisation dans le cloud. 
	- (Facultatif) Préautoriser les dispositifs en aval. 
- Sur les dispositifs en aval
	- Activez la connexion « Security Fabric » sur les interfaces requises. 
	- Activez la connexion « Security Fabric » et sélectionnez « Join Existing Fabric ». 
	- Spécifiez l'adresse IP du dispositif racine. 
- FortiGate racine 
	- Autoriser tous les dispositifs en aval (s’ils n’ont pas été préautorisé à l’étape 1)

### Configuration du FortiGate racine
![[Pasted image 20241112111826.png]]

### Configuration des FortiGate en aval (Downstream FortiGate) 
- Activer « Security Fabric Connection » et « Device Detection »
	![[Pasted image 20241112111938.png]]
- Le FortiGate en aval doit avoir été autorisé à rejoindre le Fortinet Fabric sur le FortiGate racine
		![[Pasted image 20241112112019.png]]
		![[Pasted image 20241112112034.png]]
- Onglet "Authorize" sur le FortiAnalyzer 
	- Device Manager → authorize
		![[Pasted image 20241112112107.png]]

### Synchronisation des objets 
- La synchronisation s'effectue toujours depuis le FortiGate racine 
	- Certains objets (les adresses, les services, …) sont synchronisés par défaut entre le FortiGate en amont et tous les dispositifs en aval
![[Pasted image 20241112112155.png]]
- Il peut y avoir des conflits lors de la synchronisation d’objets
![[Pasted image 20241112112240.png]]

### Options de synchronisation 
- L’option « configuration-sync » 
	- Default : le FortiGate participle à la synchronization des objets. 
	- Local : le FortiGate ne synchronise pas ses objets avec ceux du FortiGate racine. 
		- Ce FortiGate en aval propage néanmoins l'envoi d'objets synchronisé en aval.
		![[Pasted image 20241112112325.png]]
- L’option « fabric-object-unification » 
	- Commande uniquement disponible sur le FortiGate racine 
	- Default : les objets sont synchronisés.
	- Local : les objets du FortiGate racine ne seront pas synchronisés avec ceux des équipements en aval
- Synchronisation par objet 
	- Désactivée par défaut. 
	- Permet de définir, objet par objet, lesquels doivent être synchronisés. 
	- Cette option n'est pas disponible pour les objets créés sur un FortiGate en aval
	![[Pasted image 20241112112413.png]]

### Multi-VDOM mode 
- Ajout d’un FortiGate en Multi-VDOM à la Security Fabric 
	- Chaque VDOM avec ses ports affectés s'affiche lorsqu'un ou plusieurs dispositifs sont détectés. 
	- Seuls les ports derrière lesquels des périphériques ont été découverts et connectés apparaissent dans la vue Security Fabric (→ Activer « Device Detection » dans Network>Interfaces).
![[Pasted image 20241112112503.png]]

### Surveillance et récolte d'informations 
- Le FortiGate peut "surveiller" le trafic réseau et recueillir des informations sur certains périphériques s'y trouvant.
![[Pasted image 20241112112550.png]]

### Activer la détection des périphériques 
- L'activation se fait interface par interface
![[Pasted image 20241112112629.png]]

### Techniques d'identification 
- Mode avec Agent 
	- Nécessite l'utilisation du logiciel Forticlient 
		- Chaque périphérique sera identifié par un FortiClient UID. 
		- FortiClient collecte et transmet les informations à l'UTM. 
	- L'identification est indépendante de la localisation du périphérique 
- Exemple d'informations collectées 
	- L'adresse MAC 
	- L'adresse IP 
	- Le système d'exploitation 
	- Le hostname 
	- Le username
- Mode sans agent 
	- Utilise le trafic du périphérique pour l'identifier 
		- Les périphériques sont indexés par leur adresse MAC. 
	- L'identification peut se baser sur :
		![[Pasted image 20241112112814.png]]
- Exemple HTTP "User-Agent" header 
	- Capture Wireshark ou TCPdump
![[Pasted image 20241112112842.png]]

### Topology view 
- Les équipements détectés sont ajouté automatiquement dans la vue topologique de Security Fabric.
![[Pasted image 20241112112912.png]]

### Device Inventory
![[Pasted image 20241112112941.png]]
![[Pasted image 20241112113018.png]]

### Utilisation des périphériques identifiés 
- Une fois identifiés, les périphériques peuvent être utilisés dans les règles du pare-feu
![[Pasted image 20241112113042.png]]

### Automatisation 
- Automation Stitches 
	- Des flux de travail automatisés (appelés "stitches") peuvent être définis par l'administrateur 
	- Remarque : Aussi disponible sans Security Fabric. 
- Permettent une réponse automatique en fonction d'un événement 
	- Configuration d'actions automatisées selon des instructions (if/then). 
		- Une ou plusieurs actions peuvent être déclenchées suite à un événement. 
	- La détection peut se faire depuis n'importe quel périphérique du Security Fabric. 
	- L'action peut être appliquées sur n'importe quel périphérique du Security Fabric. 
- Notification des événements 
	- Le paramètre "Minimum Interval" peut être configuré pour ne pas recevoir de notifications répétées au sujet du même événement

### Automatisation : exemple
![[Pasted image 20241112113212.png]]

### Automatisation : exemple de notification 
- Les hôtes compromis peuvent être affichés dans le FortiGate. 
- FortiGate peut envoyer une notification aux administrateurs via Microsoft Teams
![[Pasted image 20241112113244.png]]

### Connecteurs « Security Fabric » (Fabric Connectors) 
- Constat 
	- Les entreprises utilisent parfois de nombreux outils et applications provenant de différents constructeurs 
		- Nombreuses alertes possibles, consoles différentes, … 
		- Difficulté à recruter des professionnels pour gérer tous ces outils. 
	- Manque d’intégration technologique au sein d'environnements complexes (IoT → multicloud) 
		- Complexe à gérer, à opérer des changements. 
		- Complexe à automatiser. 
		- Les outils informatiques ne sont pas intégrés avec les processus de sécurité.
- Facilitent la connectivité 
	- Ils facilitent la connectivité des solutions de l’architecture "Security Fabric" avec les outils de sécurité existant chez les clients. 
- Différents connecteurs disponibles 
	- Permettent de répondre aux besoins d’intégration dans différents domaines (Cloud, SDN, flux de veille sur les menaces, SSO/Identification, …)
![[Pasted image 20241112113458.png]]
- Exemple avec la prise en charge multi-cloud 
	- Le connecteur sert de passerelle pour récupérer des objets et les enregistrer sur le FortiGate. 563 
	- Permet une orchestration centralisée des utilisateurs, applications et données sur l’ensemble des environnements.
![[Pasted image 20241112113535.png]]

### Security Fabric Status Widget 
- Affiche un résumé visuel de la plupart des périphériques du Security Fabric
![[Pasted image 20241112113556.png]]

### FortiGuard Security Rating Service 
- Service réalisant des tests de sécurité du Security Fabric 
	- Nécessite une licence "Fortiguard security rating". 
	- Fonctionne en arrière plan et à la demande. 
	- Effectue différents contrôles de sécurité (password check, ...) 
	- Évaluation du déploiement du Fortinet Security Fabric en %. 
- Facilite l'identification des vulnérabilités potentielles 
	- Aide à prioriser vos tâches.
		![[Pasted image 20241112113710.png]]
- La page Security Rating est divisée en trois rubriques
![[Pasted image 20241112113732.png]]
- Vue détaillée des résultats et des recommandations de conformité
![[Pasted image 20241112113750.png]]
![[Pasted image 20241112113807.png]]
- Notifications 
	- Des recommandations sont affichées directement sur la page des paramètres concernés
![[Pasted image 20241112113849.png]]

### Vue topologique 
- Il est possible de voir la topologie du Security Fabric 
	- Topologie physique ou logique. 
	- La topologie complète est vue depuis le FortiGate racine. 570 
	Un clic droit permet par exemple : 
	- De se connecter au périphérique. 
	- D'ajouter ou d'enlever le périphérique du Security Fabric. 
	- Bannir ou réintégrer un client.
![[Pasted image 20241112113941.png]]

### Vue topologique
![[Pasted image 20241112114004.png]]
