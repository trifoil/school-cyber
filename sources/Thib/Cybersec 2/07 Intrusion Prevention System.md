#Cybersec_2_index 
[[Bac_3_Index]]
___
### IDS : Intrusion Detection System 
- Analyse l'activité d'un réseau (NIDS) ou d'un hôte (HIPS) 
	- Pour y détecter des exploits
		- Attaques connues (Il existe des signatures). 
	- Pour y détecter des anomalies 
		- Erreurs de protocoles, trafic anormal (DoS, …), attaque zero-day. 
	- De manière passive 
		- Aucune action directe sur le trafic, l'IDS est offline. 
- Collecte des informations 
	- Par exemple via l'enregistrement de tout le trafic ou uniquement du trafic concernant une attaque. 
	- Le HIDS est donc indispensable dans une optique de traçabilité d’attaque 
- Alerte les administrateurs 
	- L'IDS n'agit pas sur le trafic 
		→ Le trafic malicieux peut pénétrer dans le réseau. 
		→ L'administrateur doit réagir à postériori. 
	-  L'IDS peut cependant faire appel à un FW pour que celui-ci bloque le trafic
- Avantages des IDS (si offline) 
	- Pas d'impact sur le réseau 
		- Ni en cas de panne d'une sonde. 
		- Ni en cas de surcharge d'une sonde. 
		- N'introduit pas de latence ni de gigue. 
- Inconvénients des IDS 
	- Ne peut pas être totalement automatisé 
		- La configuration et l'administration des IDS nécessitent beaucoup de temps et de connaissances (analyse des logs). 
	- Nécessite du personnel compétent 
		- L'exploitation des remontées d'alertes nécessite des connaissances pointues. 
		- Quelle mesure prendre ? Comment distinguer un faux-positif d'un véritable incident de sécurité ? Etc. 
	- Vulnérable à certaines techniques d'évasion
		![[Pasted image 20241011141025.png]]
- Avantages des IPS 
	- Contrairement à un IDS, les attaques sont bloquées immédiatement. 
	- Permet de bloquer d’autres types d’attaques que l’antivirus. 
	- Permet de créer des règles pour protéger les systèmes vulnérables, le temps que des correctifs de sécurité soient distribués. 
- Inconvénients des IPS 
	- Possibilité de nombreux faux-positifs 
		- Un faux-positif est un paquet ou message injustement considéré comme nuisible. 
		- De nombreux paquets sains peuvent ainsi être bloqués. 
	- Possibilité d'impacts négatifs sur le réseau 
		- Paralyser le réseau si l'IPS ne fonctionne plus ou est surchargé.. 
		- Introduire de la latence et de la gigue sur le réseau (si l'IPS est mal dimensionné). 
		- Bloquer du trafic légitime à cause des faux-positifs.

### Stream normalization
- Normalisation de flux 
	- Ensemble de techniques utilisées pour reconstruire le flux de données afin de réduire ou éliminer des tentatives d'évasion ou d'insertion 
		 - Par exemple, le réassemblage de paquets fragmentés pour vérifier la validité de la transmission. 
		 - Les IPS doivent être inline pour pouvoir utiliser la normalisation de flux. 
	- Exemples 
		- TCP normalization » Mauvais checksum. 
			» Mauvaises longueur de Payload. 
			» Drapeaux TCP suspects (NULL, SYN/FIN, …). 
		-  IP Normalization 
			» Vérification de la fragmentation (un paquet dépasse le MTU). 
			» Vérification ICMP (Echo-reply sans echo-request préalable, …)

### IPS FortiGate 
- Peut détecter des attaques connues 
	- Un trafic ou un fichier correspond à une signature 
		- Les signatures sont régulièrement mises à jour par le service Fortiguard. 
- Peut détecter des anomalies 
	- Détecté par l'analyse comportementale 
		- Signatures IPS basées sur des taux. 
		- Règles spécifique contre du DoS.
		- Inspection du protocole. 
	- Exemples : 
		- Quantité de trafic anormalement élevé (DoS/flood) par rapport à la ligne de base. 
		- Utilisation anormale du protocole (drapeau SYN et RST en même temps).

### 1. IPS engine
- Le moteur IPS intervient dans de nombreuses fonctionnalités sur le FortiGate
	![[Pasted image 20241012170821.png]]

### 2. Protocol decoders
- Décodeurs de protocoles (ou analyseur de protocoles)
	1. L'IPS analyse le paquet et détecte le protocole utilisé. 
	2. Il utilise automatiquement le décodeur correspondant pour analyser chaque paquet selon les spécifications du protocole. 
	3. Il détecte les paquets/commandes mal formés ou qui ne respectent pas les spécifications du protocole. 
		- Par exemple trop d’en-têtes HTTP ou une tentative de buffer overflow.
			![[Pasted image 20241012170925.png]]

### 3. Bases de données de signatures 
- Regular signatures database 
	- Base de données réduite reprenant des signatures d'attaques classiques 
		- Inclue par défaut dans chaque version du firmware FortiGate. 
		- Provoquent rarement de faux positifs. 
		- L'action par défaut est le blocage (Default action = Block) 
- Extended signature database 
	- La base de données de signatures étendue contient des signatures supplémentaires 
		- Disponible uniquement pour les FortiGate ayant suffisamment d'espace disque ou de RAM. 
		- Ces signatures peuvent plus facilement générer des faux positifs. 
	- Plutôt utilisée pour les réseaux nécessitant une plus haute sécurité
- Mises à jour 
	- Les mises à jour permettent d'inclure automatiquement de nouvelles signatures 
		- Nécessite un abonnement au service Fortiguard IPS. 
	- Les décodeurs sont également mis à jour 
		- Assez rare, par exemple en cas de modification des RFC ou des spécifications d'un protocole. 
	- Le moteur IPS est lui-aussi mis à jour

### Choisir la base de données de signatures
![[Pasted image 20241012171423.png]]

### Listes des signatures IPS 322 L'action peut être modifiée 
L'action par défaut est généralement correcte mais peut être modifiée ou la signature supprimée :
- Si une application "maison" déclenche une signature IPS. 
- Si un correctif de sécurité bloque un exploit, il n'est plus utile de continuer à rechercher cet exploit.
![[Pasted image 20241012171838.png]]

### Encyclopédie FortiGuard 
- Disponible sur le site Web Fortiguard 
	- Contient des renseignements utiles comme les systèmes touchés et les mesures correctives recommandées.
	![[Pasted image 20241012171955.png]]

### Signatures personnalisées 
- Il est possible de créer ses propres signatures
![[Pasted image 20241012172200.png]]

### Les sondes IPS 
- Les signatures IPS 
	- Elles contiennent des paramètres (valeurs, mots clés) 
	- Ces paramètres peuvent être comparés au contenu des paquets reçus à la recherche d'une correspondance. 
- Les filtres IPS 
	- Ils regroupent un ensemble de signatures 
		- Permettent de fournir différents niveaux de protection selon les signatures incluses. 
	- Ils peuvent être personnalisés 
		- Plus un filtre sera précis, moins il consommera de ressources pour analyser le trafic. 
- Les sondes IPS 
	- Elles regroupent des filtres et/ou des signatures individuelles. 
	- Elles sont chargées d’analyser le trafic réseau : 
		- Par rapport aux signatures et filtres paramétrés. 
		- Pour y détecter des tentatives d’intrusion, des paquets mal formés ou des attaques DoS.
- Remarque 
	- Si la signature qui correspond au trafic se trouve à la fois dans la liste des signatures IPS et dans la liste des filtres IPS, FortiGate applique l'action spécifiée dans la liste des signatures.
![[Pasted image 20241012172552.png]]

### Les options de filtres 
- Le minuteur « hold time » 
	- Permet de définir la durée pendant laquelle les signatures sont maintenues avec l’action « Monitor » après une mise à jour de signature FortiGuard IPS. 
	- L’action par défaut des nouvelles signatures est activée à l’expiration du minuteur, afin d'éviter les faux positifs.  
	- Configurable entre 0 jour et 0 heure (par défaut) et 7 jours
		![[Pasted image 20241012172808.png]]
- Fichiers journaux 
	- Les logs renseignent si le minuteur est actif.
![[Pasted image 20241012172832.png]]

### Les options de filtres 
- CVE (Common Vulnerabilities and Exposures) 
	- CVE est une liste publique des informations relatives aux vulnérabilités de sécurité informatique. 
		- Fournit un descriptif succinct de chaque vulnérabilité. 
		- Fournit un ensemble de liens pour plus d’informations. 
	- Il est maintenu par l'organisme à but non lucratif MITRE. 
		- https://www.cve.mitre.org 
	- Aident les professionnels 
		- A coordonner leurs efforts visant à hiérarchiser et résoudre les vulnérabilités. 
- Format : CVE-AAAA-NNNN 
	- AAAA = l'année de publication. 
	- NNNN = un numéro d'identification unique
- Exemple de CVE 
	- La vulnérabilité qui a permis une attaque massive par le ransomware Wannacry. 
	- A l’origine de l’arrêt des lignes de production de Renault. Plus 200.000 ordinateurs on été impactés dans environ 100 pays.
![[Pasted image 20241012173001.png]]
- L’option « CVE Pattern » 
	- Permet de filtrer les signatures IPS sur la base des ID CVE ou sur un ensemble de CVE (CVE wildcard). 
	- Facilite l’utilisation des CVE : toutes les signatures marquées avec ce CVE sont automatiquement incluses
- Exemple
		![[Pasted image 20241012173818.png]]

### Ajouter des signatures à une sonde IPS
![[Pasted image 20241012174005.png]]

### Les règles sont lues dans l'ordre 
- Si possible, placer les règles les plus utilisées en premier. 
- Ne pas utiliser de trop gros filtres ni trop de filtres (consommation de ressources).
![[Pasted image 20241012174121.png]]

### Les signatures basées sur les taux/seuils 
- Blocage du trafic en fonction d'un seuil 
	- Ces signatures permettent de bloquer le trafic concerné lorsqu'un des seuils est dépassé pendant la période de temps configurée. 
	- Cela permet d'économiser les ressources du système et peut décourager une attaque répétée. 
- Elles ne devraient s'appliquer qu'aux protocoles que vous utilisez réellement 
	- Inutile de rechercher à inspecter des protocoles non utilisés dans le réseau.
	![[Pasted image 20241012174640.png]]

### Activer la protection contre les botnets 
- Fait partie de la licence IPS depuis FortiOS 6.2
	![[Pasted image 20241012174738.png]]

### Activer un profil d’inspection IPS 
- Activer le profil de sécurité IPS et sélectionner la sonde à associer à la règle de pare-feu
![[Pasted image 20241012174758.png]]

### DoS, DDoS 
- Déni de service, Déni de service distribué 
	- Une attaque DoS vise à consommer toutes les ressources 
		- La RAM, le CPU, le nombre de connexions, etc. 
	- Dans le but de ralentir ou empêcher le fonctionnement d'un système 
		- Trop de requêtes vont saturer la cible. 
	- Via des requêtes valides ou non valides 
- Bloquer une attaque DoS 
	- Appliquer une règle DoS 
		- Celle-ci exécute une action lorsqu'un seuil est dépassé. 
			» Trop de connexions à moitier ouvertes, trop de trafic provenant de la même source, … 
		- Utiliser plusieurs sondes permet de détecter différentes anomalies. 
	- FortiGate Inline 
		- La règle DoS doit s'appliquer sur un FortiGate placé entre les attaquants et les ressources à protéger

### Configuration des règles de protection DoS 
- La protection DoS peut être appliquée à quatre protocoles
	![[Pasted image 20241012175044.png]]
- Quatre types différents de détection d'anomalies peuvent être appliqués à chaque protocole supporté 
	- Flood sensor 
		- Détecte un volume élevé de trafic d'un protocole particulier (e.g. TCP SYN flood). 
	- Sweep/scan 
		- Détecte les tentatives de scan de ports (ou de réseau :ICMP sweep) ou de recherche de cibles (probing attempts).
	- Source (SRC) 
		- Détecte de gros volumes de trafic provenant d'une seule adresse IP. 
	- Destination (DST) 
		- Détecte de gros volumes de trafic destinés à une seule adresse IP.
- Conseil 
	- Consulter la Network Baseline pour déterminer les seuils à appliquer. 
	- Si vous ne disposez pas de références précises 
		- Pour la première implémentation : 
			» Ne pas bloquez le trafic. 
			» Journalisez le trafic. 
		-  Analysez les journaux pour déterminer les niveaux normaux et les pics pour chaque protocole. –
		- Réglez les seuils de façon à ce que les pics habituels ne soient pas bloqués
![[Pasted image 20241012175334.png]]

### WAF 
- Web Application Firewall 
	- Web filter = pour protéger des postes clients.  
	- WAF = Utilisé pour protéger des services Web. 
- Disponible uniquement en mode proxy 
	- Analyse en profondeur du trafic HTTP(S).
	![[Pasted image 20241012175516.png]]

### WAF signatures 
- Les signatures WAF 
	- L'UTM effectue une action prédéfinie sur le trafic qui correspond à une signature. 
	- Base étendue de signatures 
		- Peut être nécessaire dans les environnement très sécurisés mais génère plus de faux- positifs. 
- Offre une protection contre une série d'attaques contre les serveurs Web 
	- Cross-site scripting (XSS). 
	- SQL injection. 
	- Exploits web connus. 
	- Injection de commandes OS. 
	- Robots/spiders/scripts malicieux. 
	- Chevaux de Troie. 
	- Divulgation d'informations à propos du serveur (Server information disclosure). 
	- Fuites de données concernant des cartes de crédit.

### WAF Protocol Constraints
- Permet de contrôler le protocole HTTP 
	- Le nombre d'en-têtes, la taille du contenu, la version HTTP, ... 
- Permet d'éviter certaines attaques 
	- Trop nombreux en-têtes ou de trop gros contenus 
		- Vérifie les en-têtes qui pourraient saturer la mémoire du serveur Web. 
	- Illegal host name 
		- Vérifie que les noms d'hôtes ne contiennent pas de caractères interdits. 
	- Illegal HTTP Version 
		- Les versions valides sont HTTP/0.9, HTTP/1.0, HTTP/1.1.

### FortiGate implémente un WAF 
- Disponible uniquement en mode proxy
![[Pasted image 20241012175754.png]]

### FortiWeb (NSE6) 
- Offre de meilleures performances que la fonction WAF d'un FortiGate 
	- Équipement dédié à la protection Web. 
- Protection plus complète que le WAF d'un FortiGate 
	- Meilleure connaissance du protocole HTTP. 
	- Peut effectuer des analyses de vulnérabilités. 
	- Peut réaliser des tests de pénétration. 
- Contrôleur de mise à disposition d’applications 
	- Peut réécrire des paquets HTTP et acheminer le trafic en fonction du contenu HTTP.
		- – « Application Delivery Controller » (ADC) basique. 
	- Leur fonction est d’améliorer les performances, la sécurité et la résilience des applications Web. 
		- Répartition de charge serveur, traffic shaping, cache, accélération SSL, …

### Architecture 
- Inline FortiWeb 
	- Le FortiWeb est placé entre le FortiGate et le serveur Web à protéger
	![[Pasted image 20241012175924.png]]
- Offline FortiWeb 
	- Le FortiGate doit être configuré pour transférer le trafic vers le FortiWeb. 
	- Le Fortiweb peut être externe
	![[Pasted image 20241012175943.png]]

### Configuration pour rediriger le trafic vers un FortiWeb offline
![[Pasted image 20241012180002.png]]

### One-arm-sniffer IPS 
- One-arm topology 
	- Le FortiGate doit être connecté à un port en mirroring (SPAN). 
	- Il inspecte donc une copie des paquets, pas les paquets originaux. 
- Utilisation 
	- Permet de placer un FortiGate en offline pour faire du sniffing –
		- On parle de mode sniffer parce que le FortiGate ne peut pas bloquer le trafic. 
		- Permet la journalisation des actions que le FortiGate aurait appliqués aux paquets. 
	- Actuellement utilisé pour des phases de test ou d'évaluation 
		- Utilisé au début de l'introduction des IPS qui étaient trop lents et introduisaient trop de latence.

### One-arm-sniffer Configuration 
- Uniquement activable sur des interfaces physiques
![[Pasted image 20241012180124.png]]

### Conseils d’implémentation 
- Analyser les besoins 
	- Toutes les règles de pare-feu ne nécessitent pas une inspection IPS
		-  Commencez par les services les plus critiques pour l'entreprise. 
		- Commencez par monitorer avant de bloquer. 
	- Évitez d'activer l'IPS sur les politiques internes <--> internes. – Évaluer les menaces applicables 
		- Créer des sondes IPS spécifiquement pour les ressources à protéger 
			- Inutile de scanner les signatures MacOS si votre parc est en Windows. 
		- Inutile de garder des signatures si une menace n’existe plus (correctif) 
- Surveillance et ajustement régulier 
	- Surveiller régulièrement les journaux pour détecter les modèles de trafic anormaux. 
	- Ajuster les profils IPS en fonction des observations.
- Trafic chiffré 
	- N’oubliez pas le profil d’inspection SSL/SSH (deep inspection), sans lui il est impossible d’inspecter le trafic chiffré. 
- Règles DoS 
	- Il n’est pas possible d’appliquer un profil d’inspection SSL pour les règles DoS. 
	- Ces règles n'inspectent pas la charge utile des paquets mais les types de session et le volume qui leur est associé.
- Accélération matérielle 
	- Les modèles FortiGate qui prennent en charge la fonction « Nturbo » peuvent décharger le traitement IPS sur les processeurs NP6, NP7 ou SoC4. 
	- Si la commande np-accel-mode est disponible sous config system global, le modèle FortiGate prend en charge NTurbo.
		![[Pasted image 20241012183119.png]]

### Afficher les logs de l’IPS 
- Log & Report > Security Events
![[Pasted image 20241012183249.png]]

### Dépannage IPS 
- Vérifier les mises à jour : System > FortiGuard 
	- Màj envoyée à update.fortiguard.net sur TCP 443
		![[Pasted image 20241012183315.png]]
- Forcer une mise à jour manuelle
		![[Pasted image 20241012183329.png]]
- Utilisation élevée du processeur 
	- L'option 5 laisse le moteur IPS fonctionner, mais il n'inspecte pas le trafic. 
	- Si l'utilisation du processeur diminue, cela indique généralement que le volume de trafic inspecté est trop élevé pour ce modèle de FortiGate.
			![[Pasted image 20241012183402.png]]
- Mode « Fail-open » 
	- Si l’IPS manque de mémoire pour traiter les nouveaux paquets, il passe en mode fail-open.
	![[Pasted image 20241012183423.png]]
- Comportement 
	- Si le paramètre fail-open est activé : certains nouveaux paquets (en fonction de la charge du système) passeront sans être inspectés. 
	- Si le paramètre fail-open est désactivé : tous les nouveaux paquets sont abandonnés
		![[Pasted image 20241012183503.png]]
- Essayez de déterminer la cause et réalisez les ajustement nécessaires 
	- Le volume de trafic a-t-il augmenté récemment ? 
	- Le mode fail-open se déclenche-t-il à des heures précises de la journée ?