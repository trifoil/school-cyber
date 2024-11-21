#Cybersec_2_index 
[[Bac_3_Index]]
___
### Analyse antivirus
- Objectifs de l’analyse antivirus en périphérie 
	- Détecter et éliminer les logiciels malveillants en temps réel avant qu’ils n’entrent dans le réseau. 
	- Empêcher les menaces de se propager. 
	- Préserver la réputation des IP publiques de l’entreprise.

### Analyse grayware
- Détecte les programmes non sollicités
	- Ils ne sont pas vraiment dangereux mais ont des effets secondaires indésirables (perte de productivité, …) et sont donc classés comme logiciels malveillants.

### Machine learning scan (AI scan)
- Analyses basées sur des probabilités, elles augmentent donc la possibilité de faux positifs, mais peuvent détecter des attaques de type "zero-day".

### Analyse par signature 
- Signature virale 
	- A l’origine : 
		- Une signature est une suite continue de bits présente dans les malwares ou les fichiers infectés mais pas dans les fichiers non infectés. 
	- Actuellement : 
		- Différentes technologies sont utilisées pour alimenter les bases de données antivirus, mais on continue d’utiliser le terme signature. –
		- Une signature peut être une partie de code, un hash d'un fichier malveillant, une combinaisons d'attributs, des valeurs binaires à certains endroits, etc.
- Principe de l’analyse par signature 
	- Différentes technologies sont utilisées pour créer des signatures antivirus. 
	- Les signatures sont téléchargées dans des bases de données sur le matériel. 
	- Les antivirus scannent les fichiers à la recherche d’une correspondance dans leur base de données de signatures.

### Le cybercrime est une industrie
- Chaque jour, l'Institut AV-TEST enregistre plus de 350 000 nouveaux programmes malveillants (malware) et applications potentiellement indésirables (PUA). .
![[Pasted image 20240320073224.png]]

### Pas seulement sous windows 
![[Pasted image 20240320073324.png]]

### Avantages de l'analyse par signature
- Le scan est très rapide 
- Pas de faux positifs

### Limites de l'analyse par signature
- l y a trop de signatures à devoir créer 
	- Il y a tellement de variantes de malware qui sont créées chaque jour qu’il est impossible de maintenir les bases de données de signatures à jour. 
- Ne peut bloquer que les malwares connus (dont il existe une signature) 
	- Le taux de détection peut donc être assez faible lors du premier mois du malware. 
	- Nécessité de télécharger en continu une liste actualisée des signatures de virus connus. 
- Sensible à certains mécanismes d'obfuscation
- Les pirates dissimulent leurs malwares en utilisant des techniques d’obfuscation telles que : 
	- de la compression, 
	- du polymorphisme, 
	- du packer, 
	- du chiffrement, 
	- du dead code,

### Antivirus multi-scanner ou multi-moteur
Online Multi-Engine Antivirus Scanners
- VirusTotal 
- Metascan Online 
- VirSCAN 
- Jotti 
- NoVirusThanks 
- Chk4me 
- Serenity Scanner 
- …
	![[Pasted image 20240320073828.png]]

### Machine learning (AI) scan (anciennement scan Heuristique)
- Principe 
	- Recherche de codes se comportant comme des virus 
		- Par exemple, une application qui cherche à modifier des entrées de la base de registre. 
		- Attention, cela peut aussi être un comportement normal : par ex. installation d'un driver. 
	- Totalise l'ensemble des comportements similaires à ceux d'un virus 
		- Si ce total dépasse un seuil, l'application est suspecte. 
		- Rend possible la détection de virus non connus (zero-day). 
	- FortiGate scanne uniquement les fichiers exécutables Microsoft Windows 
- Inconvénients 
	- Risque de faux positifs 
		- Par défaut, les fichiers suspects ne sont pas bloqués (pour éviter les faux positifs). 
	- Consomme plus de ressources que le scan par signatures 
	- Sensible à certains mécanismes d'obfuscation

### Analyse du comportement via une sandbox
- Environnement d’exécution virtuel sécurisé 
	- Permet d'exécuter les fichiers afin d'analyser leurs comportements et révéler les menaces inconnues (pour lesquelles il n’existe pas de signature).
	-  Détection des attaques zero-day avec un haut niveau de certitude. 200 
- Détection et neutralisation 
	- En cas de détection, génération possible de signatures et transmission aux autres équipements de sécurité. 
- Reporting 
	- Un rapport détaillé sur la menace est fourni après l'analyse.
			![[Pasted image 20240320074118.png]]
- Analyse avec une sandbox locale
	- Plus rapide mais nécessite l'achat et la maintenance du boitier. 
- Analyse avec une sandbox dans le cloud 
	- Plus lent, mais pas besoin de faire la maintenance. 
	- Attention à la taille maximale des fichiers uploadé. 
	- Deux types : FortiGate cloud ou FortiSandbox cloud
			![[Pasted image 20240320074210.png]]
- Exemples de techniques d'évasion
	- Interaction humaine 
		- Le code malicieux nécessite une action humaine pour s'exécuter (un clic de souris, du scrolling, …)
	- Détection de sandbox 
		- Le malware essaie de détecter s'il se trouve dans une sandbox. 
		- S'il y arrive, la partie malicieuse reste en sommeil. 
	- Fragmentation des données 
		- Les paquets malicieux sont fragmentés en paquets plus petits. 
		- Ces petits paquets contenant chacun une partie du malware ne sont pas envoyés directement l'un après l'autre mais en attendant un certains laps de temps. 
	- Utilisation de packer ou crypter 
		- Programme dont le but va être de compresser et chiffrer, par exemple des exécutables, pour cacher un objet malveillant. 
		- Utile pour les pirates mais aussi pour le pentesting. 
	- Exemple d’un Crypter 
		- Permet de chiffrer les malware pour tenter de les rendre plus difficilement détectables. 
		- Permet de compiler du code source à la volée pour modifier les signatures. 
		- Permet d’insérer des fonctions de détection de sandbox ou de VM. 
		- …

### Limites de l'analyse par sandbox
- La configuration offrant la meilleure protection nécessite probablement trop de temps d’analyse. 
- Nombre limité de VM → Limite le nombre de fichiers analysés simultanément. 
- Les pirates utilisent des techniques d'évasion/obfuscation. 
- Plus lent que les autres types d’analyse.
	![[Pasted image 20240320074742.png]]

### FortiGuard Protection Services
- Virus Outbreak Prevention 
	- Virus n'ayant pas encore de signature 
		- Il faut un certain temps pour créer et distribuer une signature de virus, ce qui peut laisser le temps à un nouveau virus de se répendre. 
	- Principe 
		- Virus Outbreak Prevention permet de filtrer des virus n'ayant pas encore de signature en se basant sur des hashs. 
		- Une requête est envoyées en temps reel à Fortiguard pour obtenir une évaluation basée sur les hashs du fichier. 
	- Nécessite une license Zero-Hour Virus Outbreak (ZHVO)
		![[Pasted image 20240320074846.png]]
- Malware block list 
	- Liste de malwares complémentaire à la DB FortiGate 
		- Il est possible d’enrichir la base de données antivirus en liant à FortiGate une liste externe de hash à bloquer. 
	- La liste est hébergée sur un serveur web 
		- Disponible via l'URL HTTP(S) définie dans la ”Security Fabric malware hash list”. 
		- Elle se présente sous la forme d’un fichier texte contenant une liste de hachages MD5, SHA1 et SHA256. 
	- Connecteur Security Fabric 
		- La liste de blocage peut être définie comme un connecteur Security Fabric et configurée pour extraire la liste de façon dynamique. 
		- La fréquence de rafraîchissement peut être configurée.
			![[Pasted image 20240320074944.png]]
- Content Disarm and Reconstruction (CDR) 
	- Principe 
		- Certains malwares ne sont présents que dans une partie d’un fichier. 
			» Les documents Microsoft Office sont structurés comme des fichiers ZIP, contenant des dossiers avec un certain nombre de fichiers différents. 
		-  CDR enlève les contenus de fichiers jugés malicieux, exploitables ou non sûrs mais envoie le reste du document à l’utilisateur. 
		- FortiGate envoie le fichier original (complet) à une sandbox pour inspection. 
		- Le client reçoit la version propre du document qui contient une page de couverture renvoyant vers le document original via la sandbox. 
	- Contenus et protocoles supportés 
		- Fichiers PDF, fichiers Microsoft Office. 
		- Téléchargement Web HTTP, l'envoi d'e-mails SMTP, la réception d'e-mails IMAP et POP3 (MAPI n'est pas pris en charge)
			![[Pasted image 20240320075119.png]]

### Machine learning
- Domaine de l'intelligence artificielle 
	- Il permet aux ordinateurs d’effectuer des tâches pour lesquelles ils ne sont pas explicitement programmés. 
	- Ils réalisent ces tâches en apprenant à partir de données d'apprentissage.

### Machine learning et cybersécurité
- De plus en plus intégrés dans les solutions de sécurité
	- Notamment sur les solutions de protection des postes clients. 
- Les fichiers sont décomposés en petites parties 
	- Un peu comme si l'on regardait l'ADN du fichier. 
	→ permet de détecter des "traces" de malwares, même des malwares dont la signature n'est pas connue. 
-  Pas infaillible → faut garder les autres techniques.

### Limites du machine learning
- Limites du Machine learning 
	- Il est nécessaire que les résultats que l’on souhaite prédire soient différentiables. 
![[Pasted image 20240320075447.png]]
- Les algorithmes sont incapables d’extrapoler les données de manière fiable 
	- Il est donc nécessaire de faire des prédictions uniquement sur le même domaine de données que celui utilisé pour l’apprentissage. 
- Pour les classifications, il est important d’avoir suffisamment d’éléments de chaque classe.

### Protection contre les malwares
- Mécanismes d'évasion, nombreux nouveaux malwares, … 
	→ Nécessité d'analyser en continu (pas juste à un moment).
	→ Nécessité d'avoir un plan B si un malware passe quand même. 
-  Sécurité rétrospective 
	- Analyse rétrospective 
		- Il faut pouvoir réévaluer ce fichier plus tard afin de vérifier s'il est toujours sain. 
	- Analyse forensique 
		- Analyse d'un système informatique après incident. 
	- Il est avantageux de pouvoir disposer de points de contrôle à différents endroits du réseau (défense en profondeur) 
		- NGFW. 
		- Web security appliance. 
		- Email security appliance. 
		- Endpoints protection. 
		- Private cloud virtual appliance. 
		- …	
- Exemple d'importance d'une protection rétrospective et d'une bonne visibilité.
	![[Pasted image 20240320075741.png]]

### Scan antivirus 
- Moteur antivirus et base de données de signatures 
	- Chaque antivirus est constitué 
		- D’un moteur de détection. 
		- D’une base de données de signatures de virus. 
		- Chaque éditeur utilise ses propres moteurs de détection et ses signatures. 
	- Le nom d'un virus est composé de deux parties – 
	- `<vector>/<pattern> : W32/Kryptik.EMT!tr` 
	- `<vector>` : Toujours le même pour le même virus 
		» W32 pour Windows 32 bits,
		» W64 pour Windows 64 bits 
		» JS pour JavaScript 
		» … 
	- `<pattern>` : Varie selon le vendeur de solution A-V.
- Liste des Virus 
	- https://fortiguard.com/updates/antivirus
	![[Pasted image 20240320080018.png]]
	![[Pasted image 20240320080034.png]]
- Le scan analyse les fichiers à la recherche de virus 
	- Détecte et bloque les malwares en temps réel 
		- Le moteur A-V vérifie la correspondance avec la signature d'un virus connu. 
	- Empêche la propagation des menaces au sein du réseau 
		- Important si l'on ne peut pas contrôler l'A-V de tous les postes du réseau (BYOD). 
		- Important car on ne peut pas installer d'A-V sur tous périphériques du réseau (imprimantes, matériel médical, …). 
	- Préserve la réputation de l'IP publique de l’entreprise – Empêche la distribution des malwares depuis l'IP de l'entreprise. 
	- Méthode rapide et simple pour détecter des malwares 
		- Mais impossible de disposer d'une liste exhaustive et à jour de virus.
		
### Scan antigrayware
- Grayware 
	- Applications ou fichiers qui ne sont pas considérés comme des virus mais qui peuvent avoir des effets indésirables (par exemple les adwares). 
	- Ils ne sont pas franchement malveillants, mais ils ne sont pas non plus inoffensifs. 
		- Peuvent faire perdre du temps, de la productivité ou consommer des ressources. 
	- Grayware Scan 
		- Les graywares sont détectables de la même manière que les virus. 
		- Souvent ils sont détectés avec une simple signature.
	- Sur FortiGate, la protection contre les graywares est activée par défaut
	![[Pasted image 20240320080432.png]]

### AI Scan
- Activer le scan heuristique (CLI uniquement) 
	`config antivirus settings` 
		`set machine-learning-detection {enable| monitor | disable}`
	`end`
- Options 
	- Pass 
		- Active le scan heuristique et la journalisation.
		-  Laisse passer les fichiers suspicieux. 
	- Block 
		- Active le scan heuristique et la journalisation. 
		- Ne laisse pas passer les fichiers suspicieux. 
	- Disable 
		- Désactive le scan heuristique.
	==-> Conseil : Commencer par utiliser l'option pass afin d'analyser les logs et pouvoir mieux déterminer les éléments à bloquer.==
	Ordre des scans 
	1. Scan antivirus 
	2. Scan antigrayware 
	3. Scan heuristique
	
### Sandbox
- Quels fichiers envoyer à une sandbox ? 
	- Soit tous les types de fichiers supportés, soit laisser FortiGate (FortiGuard) choisir quels fichiers envoyer en fonction du climat de menace actuel. •
	- Exemptions possibles
	![[Pasted image 20240320082652.png]]
	![[Pasted image 20240320082721.png]]
		`config system fortisandbox` 
			`set inline-scan {enable | disable}`
		`end`

### Mise à jour de la base de données de signatures antivirales
- Prérequis
	- Nécessite une souscription à FortiGuard antivirus. 
	- Nécessite d'avoir activé le scan antivirus dans au moins une règle de pare-feu. 
- Vérifier si l'antivirus est à jour
	![[Pasted image 20240320082920.png]]
	`config antivirus settings` 
		`set default-db {normal | extended | extreme}` 
	`End` 
	`diagnose autoupdate status` 
	`diagnose autoupdate versions`
- Choisir une base de données de signatures (CLI only) 
	- Normal : Inclut les signatures d'attaques récentes courantes. 
	- Extended : Inclut plus de signatures de virus, actifs ou non. 
	- Extreme : Inclut une DB de virus étendues ainsi que les anciens virus dormants. Disponible sur la plupart des FortiGate mais pas tous les modèles.
- Méthodes de mise à jour 
	- Push : permet d'accepter les nouvelles mises à jour dès qu'elles sont publiées par Fortiguard. 
	- Schedule : permet de configurer des mises à jour régulières . 
	- Manual : nécessite de télécharger les paquetages et les charger manuellement dans le FortiGate.
	![[Pasted image 20240320083708.png]]

### Flow-based inspection mode
1. Mode flux (Pas de proxy) 
	- Les paquets sont mis en cache et transmis immédiatement 
		- Consomme plus de CPU que le mode proxy-based. 
		- Avantageux de disposer de puces FortiAsic. 
		- Supporte moins de fonctions de sécurité (pas SSH, pas MAPI). 
	- A l'exception du dernier paquet, les paquets ne sont pas retardés 
		- Il est nécessaire d'extraire la charge utile pour découvrir si elle est virale. 
		- Les clients perçoivent moins de latence qu’avec le mode proxy-based.
		![[Pasted image 20240320083834.png]]
2. Une copie des paquets est conservée en mémoire tampon 
	- Le moteur antivirus scanne le fichier 
		- Uniquement lorsque le dernier paquet est bufférisé. 
		- Ce dernier paquet n'est pas transmis, on attend le résultat du scan.
	- Fichiers de grande taille 
		- Les fichiers de taille supérieure à celle de la mémoire tampon ne sont pas scannés. 
	- Full scan 
		- Le scan utilise l’entièreté de la base de données antivirale configurée (Normal, extended ou extreme → Extended par défaut)
3. Si le fichier est sain : 
	- Le dernier paquet est transmis à la fin du scan
4. Si le fichier est suspect 
	- Le dernier paquet des fichiers suspects n'est pas transmis 
		- La connexion est alors réinitialisée. 
	- Si le virus est détecté alors que des paquets ont déjà été envoyés au client : 
		- Le client ne reçoit pas de message signalant le blocage du fichier. 
		- L'UTM place en cache l'URL du fichier. » Si le client tente de retélécharger le fichier, un message de blocage est envoyé. 
	- Si le virus est détecté au début du flux 
		- Un message de blocage est envoyé dès la première tentative de téléchargement

### Proxy-based inspection mode
1. Le proxy du protocole concerné intercepte la connexion et bufferise le fichier 
	- Transparent pour l'utilisateur. 
	- Aucune partie du fichier n’est transmise à l’utilisateur. 
 2. Le moteur antivirus examine le fichier entièrement bufférisé 
	 - Scanne le fichier jusqu'à 
		 - La taille maximum définie. ==-> Les virus sont souvent détectés dans les deux premiers Mo du fichier==
		 - La taille de la mémoire tampon. 
	- Un grand fichier ne peut pas être scanné 
		- Nécessité d'avoir aussi un A-V sur le poste client. 
		- Possibilité de laisser passer ou bloquer les fichiers > à la taille de la mémoire tampon. 
	- Full scan 
		- Le scan utilise l’entièreté de la base de données antivirale configurée (Normal, extended ou extreme)
3. Si les fichiers sont sains 
	- Les paquets sont transmis uniquement à la fin du scan. 
	- Une latence perceptible par les utilisateurs est possible. 
		- Suivant les performances de l'UTM et la quantité de trafic à traiter. 
	- Si tous les paquets ne sont pas reçus suffisamment rapidement, le client pourrait mettre fin à la connexion. 
		- Il est possible de configurer le proxy pour délivrer lentement les paquets afin de lui permettre de compléter son buffer et scanner le fichier. 
4. Les fichiers suspects sont soumis à l'action pass ou block 
	- Si l'action est block, aucun paquet n'a été transmis aux clients. 
	- Les clients sont toujours informés du blocage du fichier via un message.

### Page de blocage
- Exemple
![[Pasted image 20240320091210.png]]

### Comparaison des modes d’inspection
![[Pasted image 20240320091236.png]]

### Security Profiles > AntiVirus
![[Pasted image 20240320091305.png]]

### Configuration des options de protocole
→ Les options de protocole sont utilisées par les antivirus mais aussi par d’autres profils de Sécurité (filtrage Web, DLP, …)
![[Pasted image 20240320091820.png]]
![[Pasted image 20240320091914.png]]
![[Pasted image 20240320091924.png]]

### Gestion des grands fichiers
- Rappel :
	- Par défaut, les fichiers plus grand que le buffer ne sont pas scannés. 
	- Par défaut, pas de log des fichiers "trop" grands. 
	- Par défaut, pas de blocage des fichiers "trop" grands.
- Option Overzise-limit 
	- Permet d'ajuster la taille du buffer (10Mo par défaut) 
		- Un buffer plus petit permet de réduire la latence et utilise moins de RAM. 
		- Un buffer plus grand améliore la sécurité en permettant de scanner de plus gros fichiers mais consommera plus de mémoire
	`config firewall profile-protocol-options` 
	`edit <profile_name>` 
		`config <protocol_name>` 
			`set oversize-limit [1-<model_limit>]` 
			`oversize-limit Enter an integer value from <1> to <183>` 
		`end`
- Seuil par défaut de 10Mo
	- Avec le seuil par défaut de 10 Mo, seulement 0,01% des virus passent.
	![[Pasted image 20241008112023.png]]
	
### Gestion des fichiers compressés
- Compression et scan antivirus 
	- Si un fichier est compressé, sa signature est différente. 
	- Il est donc nécessaire de décompresser le fichier avant le scan. 
- Décompression des fichiers 
	- Il faut utiliser le bon algorithme de décompression. 
		- Certains format de compression peuvent être trouvé en analysant les en-têtes. 
	- Fichiers compressés protégés par mot de passe 
		- L'UTM ne pourra pas décompresser ni scanner le fichier ! 
- Compressions imbriquées (nested archive) 
	- Si un fichier a été compressé plusieurs fois, l'UTM décompressera tous les niveaux de compression. 
	- Jusqu'à 12 niveaux par défaut. 
	- Modifiable jusqu'à 100 niveaux (attention à la consommation de RAM).
- Taille limite 
	- La taille limite des fichiers compressés est différente de celle des autres fichiers.
	![[Pasted image 20241008112147.png]]

### Activer l’antivirus
- Règles de Pare-feu 
	- Pour que le profil de sécurité antivirus défini soit actif, il faudra l'appliquer à une règle de sécurité.
	![[Pasted image 20241008112242.png]]

### Eicar test file
- Fichier qui a une signature correspondant à un virus mais qui ne contient pas de charge active
![[Pasted image 20241008112304.png]]

### Conserve mode
- Quantité de mémoire limitée 
	- Si la mémoire vient à manquer, FortiOS ne peut plus s’acquitter de ses tâches et pourrait agir de manière inattendue. 
	- Pour éviter cette incertitude, FortiOS entre en « conserve mode ». 
- Seuils 
	- Seuil « red » (par ex. 88% de mémoire utilisée) 
		- FortiOS entre en « conserve mode 
			» lorsqu’il atteint le seuil rouge: 
			» Il génère des messages de journal (log). » Il génère des trap SNMP. 
			» Il affiche une bannière qui apparaît sur l'interface graphique. 
	-  Seuil extrême (Par ex. 95% de mémoire utilisée) 
		- Le « conserve mode » se poursuit, de plus les nouvelles sessions sont abandonnées. 
	- Seuil « green » (Par ex. 82 % de mémoire utilisée) 
		- Le conserve mode se poursuit jusqu'à ce que l'utilisation de la mémoire soit réduite au seuil « green ».

### Fonctionnement de l’antivirus en « conserve mode »
- Off 
	- Tout trafic devant être inspecté par le proxy antivirus est bloqué. 
	- Les nouvelles sessions ne sont pas autorisées, mais les sessions en cours continuent d'être traitées normalement, à moins qu'elles ne demandent plus de mémoire. 
	- A utiliser lorsque la sécurité est plus importante qu'une perte d'accès momentannée. 
- Pass 
	- Permet au trafic de continuer vers sa destination mais aucune analyse antivirus n’est effectuée. 
	- Les profils de sécurité n’utilisant pas le proxy antivirus sont effectués normalement. –
- One-shot 
	- Similaire au paramètre « pass » mais l’antivirus reste dans ce mode même après avoir quitté le « conserve mode ». 
	- Il reprend l'utilisation du proxy AV uniquement lorsque le paramètre av-failopen est modifié ou lorsque le FortiGate est redémarré.

### Configuration du « Conserve mode »
- Configuration des seuils 
	- Fortinet recommande de ne pas les modifier
	![[Pasted image 20241008112555.png]]
- Vérification des seuils
![[Pasted image 20241008112614.png]]
- Configuration du paramètre « av-failopen »
![[Pasted image 20241008112636.png]]
- Vérifier si le FortiGate est en « conserve mode »
	- conservemode: 0 → Le FortiGate n’est pas en “conserve mode” 
	- conservemode: 1 → Le FortiGate est entré en “conserve mode”
![[Pasted image 20241008112705.png]]

### Advanced Threat Protection Statistics 
- Fournit des statistiques en temps réel relatives aux analyses antivirus
![[Pasted image 20241008112747.png]]


### Activez la journalisation (règle de pare-feu)
![[Pasted image 20241008112810.png]]

### Hardware acceleration
- Certains modèles FortiGate possèdent des puces spécialisées 
	- Ces puces peuvent décharger le processeur des tâches d'inspection pour améliorer les performances 
	- Les modèles FortiGate avec NTurbo (NP4 ou NP6). 
	- Les modèles FortiGate avec SoC3. – Accélération matérielle uniquement disponible en mode flow-based
- Accélération matérielle uniquement disponible en mode flow-based
![[Pasted image 20241008112928.png]]
- Ce qui peut être accéléré et la manière dont l’accélération s’effectue dépend du type de puce utilisée (NP, CP, SP)
![[Pasted image 20241008113000.png]]

### Recommandations 
- Activer le scan antivirus 
	- En bordure de réseau, pour tout le trafic Internet, avec SSL deep-inspection. 
	- Sur tous les FW d'un cluster HA. 
- Configurez les mises à jour automatique Fortiguard (push updates) 
	- Si l'UTM le supporte, activer la base de données de virus étendue. 
- Journalisez les événements de sécurité 
	- Activez la journalisation des fichiers trop grands pour être scannés. 
	- Examinez périodiquement les journaux antivirus. 
- Activez l'option "Treat Windows Executables in Email Attachments as Viruses"
- N'augmentez pas la taille maximale des fichiers à scanner, sauf si cela est nécessaire 
	- Généralement pas nécessaire car les virus sont souvent des petits fichiers. 
	- Cela consommerait plus de mémoire. 
- Utilisez l'accélération matérielle 
	- Uniquement en mode flow-based. 
	- En mode proxy, le trafic ne peut pas être accéléré. 
- Ne vous limitez pas à l’antivirus du FortiGate 
	- Utilisez un antivirus sur toutes les stations de travail. 
	- Utilisez une sandbox.

### Résolution de problème
- Le service FortiGuard update est-il accessible ? 
	- Vérifiez votre connexion à l'internet. 
	- Vérifiez que le FortiGate est capable de résolutions DNS (update.fortiguard.net). 
	- Vérifiez que le port TCP 443 est ouvert. 
- La licence FortiGuard est-elle toujours valide?
![[Pasted image 20241008113621.png]]
- La version de la base de données antivirus est-elle à jour? 
	- Consultez le site web FortiGuard https://fortiguard.com/updates/antivirus 
	- Démarrer un mise à jour manuelle. 
- Le scan antivirus ne détecte pas les virus 
	- Vérifiez la configuration 
		- Vérifiez que le profil antivirus est appliqué sur au moins une règle de pare-feu. 
		- Vérifiez que le bon profil antivirus est sélectionné.
		- Vérifiez que les options de protocole sont correctes (par exemple l’inspection SSH/SSL). 
		- Vérifiez que la configuration antivirus s’applique bien à toutes les connexions redondantes.

### Résolution de problème
- Utiliser les commande de dépannage
	![[Pasted image 20241008114053.png]]

### Test des solutions antivirus
- Différents organismes réalisent des tests 
	- ICSA labs. 
	- NSS labs. 
	- AV-comparatives. 
	- Virusbull
![[Pasted image 20241008114246.png]]

### Traffic chiffré
- De plus en plus d'applications exploitent la technologie de chiffrement SSL/TLS 
	→ Les pirates peuvent masquer leurs malwares dans des communications chiffrées
	![[Pasted image 20241008170147.png]]
- Evolution du trafic chiffré pour les produits Google
	![[Pasted image 20241008170419.png]]
- Il n'est pas possible de lire son contenu 
	- Dès lors impossible de filtrer ou vérifier la présence de virus. 
- Pour contrôler le trafic, il faut déchiffrer 
	- Les NGFW disposent de fonctionnalités de déchiffrement du trafic SSL/TLS et SSH. 
	- Une fois déchiffré, il est possible d'appliquer de l'analyse antivirus, le filtrage Web ou encore le filtrage des e-mails.

### Deux méthodes d’inspection 
- SSL Certificate Inspection 
	- Méthode plus rapide (moins de latences, moins de ressources) mais moins sécurisée. 
	- Ne vérifie que la validité des certificats. 
- Full SSL Inspection (Deep inspection) 
	- Offre une meilleure protection que le mode SSL Certificate Inspection 
	- Introduit plus de latence et consomme plus de ressources. 
	- Permet de déchiffrer le trafic SSL/SSH pour appliquer des profils de sécurité.
- Utilisée pour vérifier l'identité des serveurs Web 
	- L'UTM vérifie la validité du certificat pour le trafic chiffré 
		- Les fichiers restent chiffrés et ne sont pas scannés. 
		- Si le certificat est valide, le trafic est accepté, même s'il contient des virus. 
- Utilisée pour permettre le filtrage Web 
	- Le filtrage Web est la seule fonctionnalité de sécurité qui peut être appliquée en mode SSL Certificate Inspection. 
	- Permet de vérifier que le protocole HTTPS n'est pas utilisé pour accéder à des sites normalement bloqués par le filtrage Web

### SSL Certificate Inspection Configuration
![[Pasted image 20241008170742.png]]
![[Pasted image 20241008170749.png]]

### "Full SSL Inspection"
- Principe 
	1. Le client contacte le serveur Web 
	2. Le FortiGate agit en proxy : 
		a) Il intercepte la requête du client. 
		b) Il envoie sa propre requête vers le serveur Web.
	L'UTM peut jouer le rôle de la terminaison SSL/TLS pour les protocoles (https, imaps, pop3s, smtp, ftps)
	![[Pasted image 20241008170901.png]]
	3. Le serveur Web répond en envoyant son certificat contenant sa clé publique. 
	4. Le FW reçoit le certificat suite à sa requête.
	![[Pasted image 20241008170923.png]]

### Vérification du certificat du serveur par le FW :
- Vérification s’il y a eu révocation du certificat 
	- Télécharger les listes de révocation de certificats (CRL) sur le FortiGate ou configurer le FortiGate pour utiliser OCSP. 
	- Les certificats sont identifiés par un numéro de série sur la CRL. 
- Possession du certificat de l’AC 
	- FortiGate utilise la valeur « Issuer » pour déterminer s’il possède le certificat CA correspondant dans son magasin. 
- Dates de validité 
- Vérification de la signature numérique
	![[Pasted image 20241008171013.png]]
	5. Le FW utilise le certificat pour établir un tunnel chiffré avec le serveur
	![[Pasted image 20241008171032.png]]
	6. Le FW génère un nouveau certificat au nom du serveur 
		- Pour cela, le FW doit disposer d'un certificat permettant d'émettre des certificats 
			» CA=True 
			» keyUsage=keyCertSign
	![[Pasted image 20241008171100.png]]
	 7. Le FW utilise ce nouveau certificat afin de se faire passer pour le serveur et établir un tunnel chiffré avec le client. 
	 8. Le client vérifie la validité du certificat. 
	 9. Négociation pour établir un tunnel chiffré.
	![[Pasted image 20241008171138.png]]
	![[Pasted image 20241008171148.png]]

### CA interne
- Émission de certificats 
	- Le FortiGate doit disposer d'un certificat permettant d'émettre des certificats 
		- Chaque fois qu'un utilisateur interne se connecte à un serveur SSL externe, le FortiGate doit générer une clé privée et un certificat SSL (Il agit comme une CA). 
		- La paire de clés et le certificat sont générés instantanément (pas de latence). 
	- Un tel certificat doit avoir (selon la RFC 5280) : 
		- CA=True 
		- Key Usage=KeyCertSign
- Deux possibilités 
	- Fortinet_CA_SSL 
		- Certificat local utilisé par défaut pour l'inspection SSL (auto-signé). 
	- Internal CA 
		- Autorité de certification interne au FortiGate lui permettant d'agir comme une CA subordonnée capable de délivrer des certificats. 
		- Le certificat de l'autorité de certification racine doit être importé sur les machines cliente

### "Untrusted and invalid certificates" 
- Certificats non fiables, non approuvé (untrusted) 
	- Les certificats SSL auto-signés ne sont pas considérés comme de confiance. 
	- Ils génèrent un avertissement dans le navigateur. 
		- Indiquant que le navigateur ne peut pas vérifier l'identité du site Web. 
	- Actions : ![[Pasted image 20241008171604.png]]
Allow : L'utilisateur reçoit un avertissement mais peut se rendre sur le site en ajoutant une exception au navigateur. 
Block : Connexion au serveur bloquée, pas d'exception possible. 
Ignore : FortiGate utilise toujours un certificat de confiance (Fortinet_CA_SSL ) pour remplacer celui du serveur.
![[Pasted image 20241008171622.png]]
- FortiGate effectue les contrôles suivants sur les certificats : 
	- Contrôle de la date de validité. 
	- Contrôle de la signature du certificat. 
	- Contrôle de la liste de révocation (CRL). 
- Certificats invalides (Invalid) 
	- Par défaut, les certificats invalides (les certificats expirés, …) génèrent un avertissement dans le navigateur. 
	- Il est possible d’autoriser les certificats invalides.
		![[Pasted image 20241008171749.png]]

### SSL/TLS inspection option
![[Pasted image 20241008171803.png]]

### Éviter les messages d'avertissement de certificat
1) Utiliser un certificat émit par une CA dont le certificat racine est présent dans la liste des les autorités de certification racine de confiance du navigateur.
2) Si le certificat SSL est émis par une autorité de certification privée, installez le certificat dans la liste des les autorités de certification racine de confiance
![[Pasted image 20241008171930.png]]

### HTTP Public Key Pinning
- HPKP 
	- Fonctionnalité de sécurité destinée à éviter les attaques MITM avec des certificats contrefaits. Serveur Web et navigateur doivent être compatible HPKP. 
- Technique TOFU, Trust on First Use 
	- HPKP est une technique qui s'appuie sur la confiance au premier accès. 
	- La première fois qu'un utilisateur visite un site, il va mettre en cache un certain temps les hachages d'une ou plusieurs clés publiques associées au site Web. 
	- Lors des autres visites, le navigateur s'assurera que les clés publiques correspondent à celles qu'il a stockées.
![[Pasted image 20241008172035.png]]

### Les options disponibles pour contourner le HPKP sont limitées
- Exempter l'inspection SSL pour ces sites. 
- Utiliser l'inspection des certificats SSL à la place. 
- Utiliser un navigateur qui ne supporte pas HPKP 
	- Internet Explorer, Edge et Chrome ne supporte pas HPKP.

### Protecting SSL Server 
- Utilisé pour protéger un ou plusieurs serveur(s) spécifique(s).
![[Pasted image 20241008172112.png]]
- Principe
![[Pasted image 20241008172132.png]]

### Profil de sécurité 
- SSL/SSH inspection est un profil de sécurité à assigner à une règle de pare- feu.
![[Pasted image 20241008172157.png]]
