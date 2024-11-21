#Cybersec_2_index 
[[Bac_3_Index]]
___
### Zero trust (ZT), Zero Trust Architecture (ZTA), Zero Trust Access (ZTA) 
- Le modèle zéro confiance 
	- Modèle stratégique de cybersécurité qui part du principe qu’il n’existe aucune zone de confiance : il faut toujours vérifier. 
		- Aucun utilisateur ni terminal n’est considéré comme étant de confiance (trusted) tant que son identification et son accréditation n’ont pas été minutieusement vérifiées. 
	- Zero Trust est basé sur un ensemble de technologies existantes telles que 
		- le contrôle d'accès, 
		- l'authentification (multifacteur - MFA), 
		- la segmentation, 
		- la vérification continue des utilisateurs et des appareils, 
		- la surveillance du réseau, 
		- le principe du moindre privilège,
- Aucune confiance implicite et aucun privilège n’est accordé par défaut 
	- Même si l’utilisateur se connecte depuis l’intérieur de l’entreprise avec un PC de l’entreprise
- Aucune transaction n’est autorisée sans confiance 
	- Aucun utilisateur ni terminal n'est autorisé à accéder à une ressource (fichier, application, …) tant qu’il n’est pas considéré comme étant de confiance. 
		- Peu importe sa localisation (réseau interne de l’entreprise, télétravail, …) et celle de la ressource (LAN, DMZ, cloud, …) 
		- Peu importe s’il a déjà eu un accès auparavant. 
- La confiance est obtenue après vérification d’un ensemble de paramètres 
	- Les paramètres peuvent être basés sur l'identité (authentification de l’utilisateur et/ou du terminal) et le contexte (posture check : présence d’un antivirus, localisation, …). 
- L’accès accordé après vérification est limité (Least priviledge) 
	- L’accès peut être donné à une seule ressource et pendant un temps limité. 
- La confiance n’est pas conservée 
	- Des vérifications sont effectuées continuellement, et pas seulement une fois. 
	- L’accès peut être révoqué en cours de session si l’état de sécurité change

### Le NIST définit 7 principes sur lesquels repose une architecture ZTA
1. Données, services et équipements sont des ressources 
	- L’accès et les actions sur une ressource doivent être systématiquement contrôlés et supervisés.
2. Toutes les communications devraient être sécurisées 
	- Les communications doivent être sécurisées (certificat, chiffrement), indépendamment de l’emplacement des ressources. 
3. Chaque tentative d’accès à une ressource devrait être vérifiée et évaluée 
	- Il faut définir des habilitations et contrôler les accès sur base de ces habilitations. 
		- RBAC : Role-Based Access Control. 
	- Les utilisateurs doivent être authentifiés et disposer uniquement des droits nécessaires à leurs fonctions, ni plus ni moins (principe du moindre privilège)
4. L’accès à une ressource devrait être soumis à une politique d’accès dynamique 
	- Dynamique 
		- Le niveau de sécurité nécessaire pour accéder à chaque ressource doit pouvoir s’adapter en fonction du contexte dans lequel se trouve l’utilisateur. 
	- Le contexte peut être fonction de : 
		- L’identité du client, du service ou de la ressource demandée. 
		- L’état du client demandant l’accès (versions installées, certificat, indices de compromission, …) 
		- Les attributs comportementaux (première fois que la connexion est demandée depuis un pays étranger, …) 
		- Les attributs d’environnement (localisation réseau, date de la requête, …)
5. Un système de surveillance de l'intégrité et du niveau de sécurité en temps réel devrait être implémenté 
- Idéalement, l’intégralité des composants du réseau doit être surveillée afin de détecter rapidement tout comportement suspect ou anormal. 
- CDM 
	- Continuous Diagnostics and Mitigation. Un système de diagnostic et d'atténuation des risques en continu doit être mis en place pour surveiller l'état des appareils et des applications et appliquer les correctifs nécessaires. 
- SOC 
	- Le Security Operations Center est une équipe de professionnels de la sécurité informatique qui surveille l'ensemble de l'infrastructure informatique d'une entreprise, 24h/24 et 7j/7, afin de détecter les événements de cybersécurité en temps réel et y faire face aussi rapidement et efficacement que possible. 
- SIEM 
	- Le Security Information Event Management collecte les données des journaux d’événements à partir de sources diverses, identifie les activités qui s’écartent de la norme grâce à une analyse en temps réel et applique les mesures appropriées
6. Les mécanismes d’authentification et d’autorisation devraient être dynamiques et strictement appliqués avant qu’un accès soit autorisé 
	- L’entreprise devrait disposer d'un système de gestion des identités, des habilitations et des accès et d'un système de gestion des actifs. 
		- ICAM : Identity, Credential, and Access Management. 
		- IAM : Identity and Access Management. 
	- L’entreprise devrait mettre en place une surveillance continue avec réauthentification et réautorisation éventuelles tout au long des transactions. 
7. L’entreprise devrait assurer une supervision constante de la sécurité 
	- L’entreprise doit collecter le maximum d’informations possibles sur le niveau de sécurité des actifs, l’infrastructure réseau et les communications en cours. 
	- La traçabilité et l’exploitation continue des informations collectées doivent servir à l’amélioration constante de la sécurité du SI.

### ZTNA : Zero Trust Network Access 
- ZTNA est une fonctionnalité de Zero Trust Access (ZTA) qui se concentre sur le contrôle d'accès aux applications 
	- ZTNA de Fortinet n'accorde l'accès par session à une application qu'après vérification de différents paramètres. 
		- Périphérique, utilisateur, contexte. 
	- Le contrôle s’effectue à chaque nouvelle session. 
		- Car entre cette session et la précédente, le PC s’est peut-être fait infecter ou voler. 
	- Le processus de contrôle s’effectue indépendamment de l’emplacement du client et de la ressource. 
		- Indépendamment dans le sens où des contrôles sont effectués peu importe la localisation, mais ces contrôles peuvent être différents selon l’environnement. 
		- Par exemple, un accès peut nécessiter une authentification 2FA depuis l’extérieur mais pas depuis l’intérieur de l’entreprise
- Fortinet ZTNA contrôle les accès en : 
	- Vérifiant l’identité des périphériques client (Via des certificats). 
	- Authentifiant l'identité de l'utilisateur (MFA supporté). 
	- Vérifiant l’autorisation de l'utilisateur (Habilitations, RBAC). 
	- Vérifiant la posture en fonction du contexte. 
		- Réalisant des contrôles basés sur des attributs et contextes définis dans des tags zéro confiance (Zero-trust tags). 
		- Par exemple, ZTNA peut vérifier : la localisation, présence d’un antivirus, d’un certificat, d’une connexion à FortiClient EMS, la présence d’un fichier spécifique, d’un OS spécifique, d’une connexion à un domaine AD, etc.

### Principe
![[Pasted image 20241023073304.png]]

### Deux modes ZTNA 
1. ZTNA access proxy (Le proxy d'accès ZTNA) 
	- Utilisé pour permettre aux utilisateurs d'accéder aux ressources par le biais d'un proxy en SSL. 
		- Un proxy HTTP pour les application Web. 
		- Un TFAP (TCP Forwarding Access Proxy) pour les autres applications supportées (SSH, RDP, …). • Simplifie l'accès à distance en éliminant l'utilisation d’un dial-up VPN. • Des règles ZTNA et le balisage (ZTNA tag) offrent un contrôle supplémentaire des utilisateurs et des périphériques clients.
2. ZTNA IP/MAC filtering (ZTNA secure access) 
	- Ce contrôle d'accès est typiquement utilisé lorsque les terminaux sont physiquement situés dans le réseau de l'entreprise. 
	- Utilise les règles et les tags ZTNA pour mettre en œuvre un accès zéro confiance basé sur les rôles. 
		- Ce contrôle d'accès combine les adresses IP/MAC (règles de pare-feu) avec des tags ZTNA pour l'identification et le contrôle de la posture de sécurité. 
		- Ce mode ne nécessite pas l'utilisation du proxy d'accès

### FortiClient 
- Solution de sécurité pour les périphériques clients 
	- FortiClient permet à chaque appareil - local ou distant, fixe ou mobile - de s'intégrer à FortiClient EMS. 
	- Plusieurs plates-formes supportées : 
		- Windows, Mac OS, Linux, iOS, les appareils mobiles Android et Chromebook. 
- FortiClient peut être utilisé soit avec FortiClient EMS uniquement, soit dans la Security Fabric
		![[Pasted image 20241023074403.png]]

- Fournit des informations au FortiClient EMS lorsqu'il s’y enregistre : 
	- Informations sur le client (réseau, système d'exploitation, version, etc.). 
	- Informations sur l'utilisateur connecté. 
	- Informations sur l’état de la sécurité (dans ou en dehors de la Security Fabric, antivirus à jour et activé, vulnérabilités détectées, etc.). 
- Demande et obtient un certificat de périphérique client 
	- Demande et obtient un certificat de périphérique client auprès de l'autorité de certification EMS ZTNA lors de sa première tentative de connexion. 
		- Vous ne pouvez pas utiliser les fonctionnalités de FortiClient tant que celui-ci n'est pas connecté à FortiClient EMS et qu'il n'a pas de licence. 
	- Le client utilisera ce certificat pour s'identifier auprès d’un FortiGate. 
- Est configuré via le profil de sécurité que l'administrateur a configuré dans FortiClient EMS

### FortiClient EMS 
- Solution de gestion centralisée de FortiClients 
	- Permet de configurer de manière centralisée des profils de sécurité avec lesquels les FortiClients seront approvisionnés. 
		- Vous pouvez y créer, modifier et supprimer des règles d’étiquetage zéro confiance. 
	- Permet l'administration des connexions des terminaux FortiClient 
		- Acceptation, déconnexion et blocage des terminaux.
	- Il apporte une visibilité sur l'ensemble des FortiClients du réseau 
		- L'état, le système (versions obsolètes?), les règles, les exceptions, la sécurité,… 
	- Il comprend des fonctions d’automatisation pour la gestion des périphériques et le dépannage. 
	- Dans une architecture ZTNA, vous ne pouvez modifier les configurations d’un FortiClient qu'à partir du FortiClient EMS
- Émet et signe le certificat du FortiClient 
	- Avec l'UID du FortiClient, le numéro de série du certificat et le numéro de série de l’EMS. 
	- FortiClient EMS synchronise ensuite le certificat Client avec le FortiGate. 
	- FortiClient EMS partage son certificat EMS ZTNA CA avec le FortiGate. 
		- Afin que les FortiGates puissent l'utiliser pour authentifier les certificats clients.
- Utilise des règles Zero Trust pour étiqueter les clients (tag) en fonction des informations dont il dispose sur chaque client. 
	1. EMS envoie des règles zéro confiance aux périphériques client. 
	2. Le FortiClient vérifie les clients à l'aide des règles zéro confiance fournies et envoie les résultats à EMS. 
	3. EMS regroupe dynamiquement les clients à l'aide du tag configuré pour chaque règle. 
	4. EMS synchronise les balises ZTNA avec les FortiGates. 
- Met à jour les informations relatives aux clients lorsque celles-ci changent 
	- Synchronise ces mises à jour avec les FortiGates
		![[Pasted image 20241023074748.png]]

### Les équipements et leur rôle (suite) 
- FortiGate 
	- Maintient une connexion continue avec FortiClient EMS 
		- Afin de synchroniser les informations sur les clients (l'UID du FortiClient, le SN du certificat client, le SN du FortiClient EMS, les détails du réseau (adresses IP et MAC), etc.)

### Vérification des sessions actives ZTNA 
- Changements de posture des terminaux clients 
	- Ils déclenchent la revérification des sessions actives. 
		- Si le terminal n'est plus conforme aux règles ZTNA, la session est interrompue. 
- Les tags ZTNA sont mis à jour par le FortiClient EMS 
	- FortiGate surveille ces mises à jour. En cas de changement, les sessions ZTNA actives doivent à nouveau correspondre à la politique ZTNA. 
- Changements des règles ZTNA 
	- Les modifications apportées aux règles ZTNA déclenchent également une nouvelle vérification de l'appareil client par rapport à la politique

### ZTNA avec ou sans client (client and clientless ZTNA) 
- Client-initiated, endpoint-initiated 
	- Le modèle ZTNA initié par le client utilise un agent sur les clients (Par exemple, FortiClient). 
	- Avantages 
		- Fonctionne que vous accédiez à des ressources dans le cloud ou sur site. 
		- Offre une meilleure visibilité et un meilleur contrôle des appareils
- Service-initiated, clientless 
	- Le modèle ZTNA initié par le service ou "sans client" utilise une architecture de reverse proxy. 
	- Pas d'agent sur les clients mais un plug-in de navigateur pour créer un tunnel sécurisé et effectuer l'évaluation de l'appareil et la vérification de la posture. 
		- Il ne prend généralement en charge que les applications basées sur HTTP/HTTPS. 
		- Plutôt que de résider localement, le logiciel doit être téléchargé à chaque connexion, ce qui ralentit et dégrade l'expérience de l'utilisateur. 
	- N'offre pas le même niveau de contrôle ou de visibilité qu'un agent 
		- Or un élément important de ZTNA consiste justement à évaluer la posture de l'appareil et son état de vulnérabilité.

### Zero-Trust tagging rules 
- Configuration des règles de balisage Zéro confiance sur FortiClient EMS
![[Pasted image 20241023081849.png]]
- Configuration des règles de balisage zéro confiance sur FortiClient EMS
![[Pasted image 20241023081911.png]]
![[Pasted image 20241023082115.png]]
### Zero Trust tag monitor 
- Menu de l’EMS affichant toutes les règles zero trust.
![[Pasted image 20241023082144.png]]

### Gestion des certificats sur le FortiClient EMS 
- Default_ZTNARootCA 
	- FortiClient EMS dispose d’un certificat racine par défaut. 
		- La CA ZTNA utilise ce certificat racine pour signer les CSR des terminaux FortiClient. 
	- Vous pouvez révoquer tous les certificats ou le certificat individuel d’un FortiClient.
![[Pasted image 20241023082346.png]]
- Certificats 
	- Sous Windows, les certificats sont installés directement dans le magasin de certificats. 
	- Sur d'autres systèmes d'exploitation, consultez la documentation du fournisseur. 
- FortiGate 
	- Les informations du certificat dans le magasin du client doivent correspondre aux informations du FortiClient EMS et du FortiGate sinon l'authentification du certificat client peut échouer
![[Pasted image 20241023082457.png]]

### Authentification par certificat 
- Obtention du certificat client 
	- Lorsqu'il s'enregistre auprès du FortiClient EMS, le FortiClient soumet automatiquement une demande CSR. 
	- Le FortiClient EMS signe et renvoie le certificat client. 
		- Ce certificat est stocké dans le magasin de certificats du système d'exploitation pour les connexions ultérieures. 
	- Les informations sur les terminaux sont synchronisées avec FortiGate et FortiClient EMS. 
	- Actuellement, ZTNA prend en charge les navigateurs Microsoft Edge et Google Chrome. 
- Révocation du certificat client 
	- Lorsqu’un client se déconnecte ou est désenregistré de FortiClient EMS, son certificat est supprimé du magasin de certificats et révoqué sur FortiClient EMS.
- Par défaut, l'authentification du certificat client est activée sur le proxy d'accès 
	- Lorsque le FortiGate reçoit la requête HTTPS, le processus WAD demande au client de s'identifier à l'aide de son certificat. 
	- Si le client répond avec le bon certificat, l'UID du client et le SN du certificat peuvent être extraits : 
		- Si l'UID du client et le SN du certificat correspondent à l'enregistrement du FortiGate, le client est autorisé à poursuivre le traitement de la règle de proxy ZTNA. 
		- Si l'UID du client et le certificat SN ne correspondent pas à l'enregistrement du FortiGate, le client est empêché de poursuivre le traitement de la règle de proxy ZTNA. 
	- Si le client annule et répond avec un certificat client vide, 
		- Le client est autorisé à poursuivre si l’option empty-cert-action est configurée sur accept. Sinon, FortiGate bloque le client et l'empêche de poursuivre
			![[Pasted image 20241023082657.png]]

### ZTNA HTTPS access proxy (Le proxy d'accès ZTNA) 
- SFortiGate fonctionne comme un reverse proxy pour un serveur HTTP(S)
![[Pasted image 20241023082803.png]]

### Configuration ZTNA HTTPS access proxy 
- Configuration à réaliser sur le FortiGate 
	- Connecteur Security Fabric FortiClient EMS 
		- Le FortiGate maintient une connexion continue avec le serveur EMS pour synchroniser les informations sur les terminaux et les balises ZTNA. 
	- Serveur ZTNA 
		- Il définit l’adresse VIP du proxy d'accès et les serveurs réels auxquels les clients peuvent se connecter. 
	- Règles ZTNA 
		- Permet de définir des tags ou des groupes de tags ZTNA pour appliquer l'accès basé sur le rôle. – Vous pouvez également configurer des profils de sécurité pour protéger ce trafic. 
	- [Optionnel] Authentification 
		- ZTNA prend en charge les méthodes HTTP et SAML
- Configurer la connexion entre FortiGate et FortiClient EMS 
	- FortiGate utilise un connecteur Fabric pour se connecter au FortiClient EMS
![[Pasted image 20241023083059.png]]
- Configurer un serveur ZTNA (proxy d’accès) 
	- Définir l’adresse VIP du proxy d'accès et le serveur réel auquel les clients peuvent se connecter
![[Pasted image 20241023083146.png]]
![[Pasted image 20241023083201.png]]
- Configurer les règles ZTNA 
	- Permet de définir des balises et/ou des groupes de balises ZTNA afin d’appliquer le contrôle d'accès (basé sur le rôle)
![[Pasted image 20241023083234.png]]
- Configurer l’authentification
![[Pasted image 20241023083303.png]]

### ZTNA TCP Forwarding Access Proxy (TFAP) 
- RDP, SSH, SMB 
	- ZTNA prend en charge les applications basées sur HTTP/HTTPS. 
	- TFAP permet de transmettre le trafic RDP, SSH, SMB vers les ressources correspondantes
![[Pasted image 20241023083504.png]]

### Configuration 
- Choisir TCP forwarding, sinon les étapes sont les mêmes que pour l’access proxy (serveur, règles, authentification)
![[Pasted image 20241023083542.png]]

### ZTNA SSH Access Proxy 
- Même rôle que TFAP mais spécifiquement prévu pour le trafic SSH 
	- Permet d’appliquer les contrôles ZTNA au trafic SSH. 
	- Permet l'application de l'inspection approfondie du trafic SSH (SSL/SSH inspection). 
	- Permet la validation de la clé d'hôte SSH du serveur (facultatif). 
	- Permet l'utilisation d'une authentification utilisateur à usage unique 
		- Pour ne pas devoir s’authentifier au proxy d'accès SSH ZTNA et puis au serveur SSH
### ZTNA IP/MAC-Based Access Control 
- Utilisé pour accéder à un serveur Web interne lorsque les terminaux sont physiquement situés sur le réseau de l'entreprise (On-net).
![[Pasted image 20241023083711.png]]

### Comparaison ZTNA vs VPN 
- Granularité 
	- Un VPN donne généralement un plus large accès aux ressources 
		- Par exemple, l’accès à un réseau entier. 
	- Le ZTNA traite chaque utilisateur et appareil individuellement 
		- Seules les ressources auxquelles l’utilisateur et l’appareil sont autorisés à accéder sont mises véritablement à disposition. 
-  Visibilité 
	-  Le VPN n’a pas conscience du trafic et de son utilisation 
		- Cela rend plus difficile la visibilité de l’activité des utilisateurs et de l’utilisation des applications. 
	- ZTNA est micro-segmenté 
		- Il peut offrir une visibilité accrue sur l’activité des applications. 
			- Cette possibilité facilite grandement la surveillance de l’état des applications, la planification des capacités, la gestion et l’audit des licences
- Sécurité 
	- Une architecture Zero Trust réduit considérablement la surface d'attaque 
		- Car les ports et les applications sont invisibles à moins d'être authentifiés et autorisés. 
		- Car il impose une vérification permanente des utilisateurs et des appareils. 
		- Car il fournit un accès minimal (Least priviledge) aux utilisateurs et aux appareils en fonction de leur rôle dans l’entreprise. 
		- Car il n’y a pas de risque de laisser un VPN accidentellement ouvert. 
	- Une architecture Zero Trust entrave considérablement les possibilités de déplacement latéral d’un pirate sur le réseau (micro-segmentation). 
	- État de sécurité de l’appareil : 
		- Un VPN d’accès à distance n’a aucune connaissance de l’état de fonctionnement d’un périphérique client. 
		- ZTNA intègre la conformité et l’état de sécurité des appareils dans les politiques d’accès. 
			» Cette approche réduit considérablement le risque de vol ou de fuite de données.
- Expérience utilisateur 
	- Les clients VPN d’accès à distance sont connus pour offrir une expérience utilisateur médiocre 
		- Ajout de latence, problèmes en matière de connectivité, à quel VPN se connecter, … 
	- Avec ZTNA, l'utilisateur n'a plus besoin de savoir à quel VPN se connecter ni où se trouvent les ressources. 
		- L'utilisateur clique simplement sur l'application pour obtenir une connexion sécurisée, que l'application soit sur site, dans un cloud public ou un cloud privé. 
		- ZTNA établit automatiquement des connexions sécurisées à la demande, la plupart des utilisateurs ne remarqueront même pas la présence de la solution ZTNA. 
- Mise en conformité 
	- Avec ZTNA, chaque demande d’accès est évaluée et peut être enregistrée 
		- Il est donc plus facile de constituer la documentation relative à la conformité. 
		- Les audits sont simplifiés, car il existe une chaîne de preuves visibles pour toutes les demandes d'accès.
- Flexibilité et agilité 
	- Les VPN n’offrent pas la même granularité que les solutions ZTNA. 
		- L’installation et la configuration d’un logiciel client VPN sur les terminaux de tous les utilisateurs et la configuration de multiples tunnels VPN peuvent s’avérer complexes : nœuds multiples, règles d’accès au pare-feu, gestion des adresses IP, des flux de trafic et du routage. 
	- ZTNA est plus agile dans des environnements qui changent rapidement, avec des utilisateurs, des applications et des appareils qui vont et viennent. 
		- Il est beaucoup plus facile d’ajouter ou de supprimer des règles de sécurité et les autorisations des utilisateurs en fonction de leurs besoins immédiats. 
	- Déploiement ZTNA 
		- ZTNA ne nécessite pas d’être déployé en une fois dans l'ensemble de l’infrastructure mais peut être déployé pour des groupes d'utilisateurs ou des applications spécifiques. 
		- ZTNA utilise les méthodes d'authentification existantes et les méthodes d'accès aux applications natives, ce qui se traduit par une expérience utilisateur transparente.
![[Pasted image 20241023084912.png]]
![[Pasted image 20241023084923.png]]

### Limites du ZTNA 
- BYOD 
	- Le Zero Trust dans un lieu de travail qui s'appuie fortement sur le BYOD peut nécessiter beaucoup de travail, surtout en amont. 
- Nombre élevé d’applications 
	- Un grand nombre d’applications devant être surveillées et sécurisées selon les normes Zero Trust peut rendre difficile la mise en œuvre de l’architecture ZTA. 
- Dépendance aux fournisseurs 
	- La mise en œuvre du ZTNA peut entraîner une dépendance accrue vis-à-vis des fournisseurs de solutions de sécurité spécifiques. 
	- Cela peut limiter la flexibilité et la portabilité des infrastructures, et peut également entraîner des problèmes de compatibilité avec d'autres systèmes ou solutions
- Latence 
	- Le ZTNA peut potentiellement entraîner une augmentation de la latence et une réduction des performances réseau. 
	- Cela est dû aux exigences de chiffrement et de déchiffrement des données, ainsi qu'à la nécessité de vérifier l'authentification de chaque utilisateur avant d'autoriser l'accès aux ressources. 
- Coût : 
	- L'adoption du ZTNA peut entraîner des coûts supplémentaires, notamment pour l'achat et la configuration de solutions logicielles ou matérielles spécifiques. De plus, la gestion et la maintenance continues de l'infrastructure ZTNA peuvent nécessiter des ressources supplémentaires.