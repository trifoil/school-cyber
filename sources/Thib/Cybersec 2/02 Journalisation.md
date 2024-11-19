#Cybersec_2_index 
[[Cybersec_2_index]]
___

### Journalisation
- Lorsque du trafic transite par l'UTM, celui-ci peut enregistrer cette activité (log messages) dans des fichiers journaux (log files)
![[Pasted image 20240923112336.png]]

### Avantages de la journalisation
- Apporte de la visibilité sur les activités du réseau
	- Fournir des données pour localiser certains problèmes (pertes de performance, erreurs lors de l'utilisation d'un tunnel VPN IPsec, …)
	- Lister les menaces les plus rencontrées.
- Facilite l’établissement d’une ligne de base du réseau.
	- Permet de disposer de statistiques sur le trafic.
- Important du point de vue de la sécurité
	- Enregistrement de différents événements critiques (traçabilité)
	- Parfois la journalisation est obligatoire de par la loi

### Inconvénients de la journalisation
- La journalisation consomme des ressources
	- Plus il y a d’événements à journaliser, plus il y a consommation de ressources CPU, mémoire, espace disque.
	- Une journalisation trop intensive peut réduire les performances 
```
	config system global
	 set sys-perf-log-interval <number from 0-15> 
	end
```

### Conseils
- Créer un plan de gestion des logs
	- Quelles activités voulez-vous/devez-vous consigner? 
	- Quel dispositif de journalisation est le mieux adapté à votre situation? 
	- Les journaux doivent-ils être archivé? Combien de temps? 
	- Etc.
- Réviser régulièrement votre plan

### 1. Traffic Logs (Les journaux de trafic)
- Ils enregistrent des informations sur le trafic qui traverse le FortiGate
	- Appelé aussi "firewall policy logging" car le trafic traversant l'UTM est nécessairement autorisé via une règle de pare-feu.
- Ils contiennent trois sous-types : forward, local et sniffer.
	- Journaux de trafic Forward
	- Les journaux de trafic Local
	- Les journaux de trafic Sniffer

### 2. Event Logs (Les journaux d'événements)
- Ils enregistrent les événements système et d'administration
	- Par exemple, des ajouts ou modifications de la configuration, la connexion d'un administrateur, ou l’activation d'un tunnel VPN IPsec
- Ils contiennent les sous-types suivants
	- Les journaux d'événements System
	- Les journaux d'événements User
	- Les autres journaux d'événements (Router, VPN, Endpoint Control, …)

### 3. Security logs (Les journaux de sécurité)
- Ils enregistrent des journaux concernant les événements de sécurité
	- Contiennent les logs relatifs aux actions prises par les profils de sécurité Application (Control – Antivirus – DLP – Anti-Spam (Email Filter) – Web Filter – Intrusion Protection – Anomaly (DoS-policy) – WAF)
	- Le type de log = utm

### Types et sous-types de journaux
![[Pasted image 20240923113305.png]]

### Niveau de sévérité des journaux
- Les journaux sont classés par niveau de sévérité. 
- Le niveau de sévérité est utilisé par les administrateurs pour définir quelles informations doivent être enregistrées (log level, priority level).
![[Pasted image 20240923113337.png]]

### Forward log example
- Il est possible de trier les journaux
![[Pasted image 20240923113450.png]]
![[Pasted image 20240923113438.png]]

### Security log example
- Par défaut, ils sont visibles dans le menu Forward Traffic
![[Pasted image 20240923113520.png]]

### En-tête d'un log
- Chaque journal a une disposition standard composée d'une section en-tête et d'une section corps. 
- L'en-tête est similaire pour tous les types de log. 
- La combinaison “type + sous-type” determine le contenu du corps d'un log
![[Pasted image 20240923113558.png]]

### Corps d'un log
- Il varie en fonction du type de log. 
- Il indique la raison pour laquelle le journal a été créé.
![[Pasted image 20240923113733.png]]

### Affichage des logs en CLI
![[Pasted image 20240923113802.png]]
![[Pasted image 20240923113813.png]]

### “Performance statistic logging”
- Fonction qui crée une entrée de journal périodique contenant des informations générales sur les performances du FortiGate
	- Fournit des informations sur l'utilisation du CPU et de la mémoire, ainsi que le nombre de sessions simultanées. 
	- Peut être utile lors du dépannage des changements de comportement en termes d'utilisation des ressources
	![[Pasted image 20240923114044.png]]

### Local Logging
- Enregistrement sur disque
	- Vous pouvez activer l'enregistrement local sur le disque (disk logging). 
	- Si le disque dur local est utilisé pour le « WAN Optimization », vous ne pouvez pas utiliser le disque pour les logs.
- Sans disque dur
	- Les informations dans FortiView s'affichent en temps réel uniquement.
- Par défaut, les logs de plus de 7 jours sont effacés du disque dur
![[Pasted image 20240923114319.png]]
- Surveiller l’espace disque
	- Une partie du disque est réservée (~25%)
		![[Pasted image 20240923114505.png]]
		![[Pasted image 20240923114514.png]]
- Formule
	- Disque – log = réservé (118145MB – 88608MB = 29537MB)
	- Réservé/disque*100 = réservé % (29537/118145*100 = 25%)
- Avertissement
	- Des messages d’avertissement sont affichés avant que le disque ne soit plein. 
	- Les seuils sont configurables :
		![[Pasted image 20240923114625.png]]
- Si le disque est rempli?
	- FIFO : les logs les plus anciens sont remplacés par les nouveaux. 
	- Possible de configurer le FortiGate pour stopper la journalisation

### Sauvegarde sur FortiAnalyzer ou FortiManager
- Les FortiGates doivent être enregistrés auprès du FortiAnalyzer/FortiManager pour pouvoir lui envoyer des logs. 
- Utilise le port 514, les logs sont compressés (format LZ4) et transmis en clair. 
- L'envoi de logs peut être chiffré (OFTP chiffré avec SSL).
![[Pasted image 20240923115309.png]]

### FortiAnalyzer vs FortiManager
- FortiAnalyzer (FAZ)
	- Équipement dédié au stockage et à l'analyse les fichiers journaux. 
	- Prévu pour stocker et traiter de grandes quantité de logs.
- FortiManager (FMG)
	- Destiné à la gestion centralisée de plusieurs périphériques Fortinet. 
	- Peut aussi stocker des logs et générer des rapports. 
	- Les volumes de logs sont limités à un montant fixe (par jour) qui est inférieur à celui d'un FortiAnalyzer.
- Jusqu'à 3 FAZ/FMG par FortiGate (Redondance)

### FortiCloud
- Service hébergé dans le cloud (hosted service)
	- Service de gestion des logs et de la sécurité. 
		- Stockage à long terme des logs et génération de rapports. 
	- Nécessite un abonnement. 
	- Utile dans les petits réseaux afin d'éviter l'achat d'un appareil de journalisation dédié (dedicated logging appliance).

### Configuration
- Définir de l'équipement vers qui envoyer les logs
	![[Pasted image 20240923115702.png]]
- La configuration d'un 2ème et/ou 3ème équipement distant doit se faire en CLI.
![[Pasted image 20240923115724.png]]
- Envoi des logs vers FortiCloud 
	- Nécessite d'activer le compte FortiCloud via le Dashboard en premier.
![[Pasted image 20240923115828.png]]
- Envoi des logs vers un serveur Syslog ou un FortiSIEM
![[Pasted image 20240923115852.png]]
- Il est possible de configurer jusqu'à quatre serveurs Syslog ou FortiSIEM distants.
```
# config log <syslogd | syslogd2 | syslogd3 | syslogd4> setting 
	set status enable 
	set server <syslog_IP> 
	set format [default | csv | cef]
```
- VDOM
	- Par défaut, la configuration est globale. 
	- Par défaut, le VDOM root est responsable de l’envoi des logs
- override-setting
	- S’il faut définir un FortiAnalyzer ou un serveur syslog different pour un VDOM, la configuration se fait en CLI. 
	- Dans ce cas, le VDOM concerné enverra les logs (et pas le VDOM root
```
# config vdom
	edit <VDOM_Name>
		config log setting 
			set faz-override enable 
			set syslog-override enable 
	end 
# config log fortianalyzer/fortianalyzer2/fortianalyzer3 override-setting
```

### Journalisation fiable
- Reliable logging
	- Utilise TCP au lieu de UDP (port 514). 
	- Logs vers FortiCloud : utilise TCP 
	- Logs vers FortiAnalyzer ou FortiManager
		- Si configuré en GUI, TCP est automatiquement utilisé. 
		- Si configuré en CLI, UDP est utilisé par défaut
```
# config log fortianalyzer setting 
	set reliable [enable/disable] 

# config log syslogd setting 
	set mode udp | reliable | legacy-reliable
```

- TCP doit être utilisé pour pouvoir chiffrer l’envoi des logs
```
# config log fortianalyzer setting 
	set enc-algorithm [high-medium | high | low
```
- Si l’équipement distant est indisponible
	- FortiGate met les journaux en cache (processus miglogd). 
	- Suffisant pour stocker les logs le temps d’un redémarrage de l’équipement distant.
- Afficher des statistiques sur les processus
![[Pasted image 20240923120318.png]]
- Il est possible de choisir les logs qui seront envoyés à un serveur syslog ou un FortiAnalyzer
![[Pasted image 20240923120342.png]]

### Activation de la journalisation
- Se fait au niveau de la règle de pare-feu
	- Active la journalisation du trafic traversant le pare-feu
	![[Pasted image 20240923120420.png]]

### Configuration
- Il est possible de spécifier quel sous-type de trafic devra être journalisé concernant les types de journaux « Event » et « Local Traffic »
![[Pasted image 20240923120458.png]]
![[Pasted image 20240923120513.png]]

### Journalisation et accélération matérielle 
- L'accélération matérielle affecte la journalisation
	- Le trafic déchargé sur des SPU n’est pas journalisé. 
	- Si vous devez journaliser, il faut désactiver l'accélération matérielle.
- Exception
	- Il est possible de journaliser les paquets utilisant les processeurs NP7 mais avec une dégradation des performances de l’accélération matérielle

### Tester la journalisation
![[Pasted image 20240923120557.png]]

### Anonymiser les logs
- Parfois requis de par la loi
```
# config log setting
	set user-anonymize enable 
end
```
![[Pasted image 20240923120642.png]]

### Log & Report
![[Pasted image 20240923120700.png]]

### Filtrage de l'affichage des logs

![[Pasted image 20240923120748.png]]

### Filtres rapides

![[Pasted image 20240923120804.png]]

### Afficher les logs relatifs à une règle de pare-feu
![[Pasted image 20240923120822.png]]

### Alertes
- Notifications par email
	- Nécessite de définir un serveur SMTP à contacter 
		![[Pasted image 20240923120941.png]]
		![[Pasted image 20240923120951.png]]

### Configuration des notifications par email via la CLI
- Parfois requis de par la législation
![[Pasted image 20240923121015.png]]

### Threat Weight in FortiOS
- Permet de configurer ses propres niveaux de menace
	- Permet de classer les logs en fonction de ses propres niveaux de menace. 
	- Permet de prioriser plus facilement les actions en fonction des niveaux de menaces rencontrées
![[Pasted image 20240923121052.png]]

### Affichage du niveau de menace
-  Visible dans dashboard > Security
![[Pasted image 20240923121132.png]]

### Télécharger des logs en GUI
![[Pasted image 20240923121149.png]]

### Sauvegarde des logs
- Vers l’USB ou un serveur FTP/TFTP
	- Les logs sont enregistrés en format compressé LZ4. 
	- Il est recommandé de stopper « miglogd » et « reportd ».
![[Pasted image 20240923121236.png]]

- Log rolling
	- Similaire à une compression, permet de réduire l’espace disque occupé par les journaux. 
	- Automatique lorsque les journaux atteignent une taille de 20 Mo (configurable).
- Log uploading
	- Les logs (compressés) peuvent être automatiquement envoyé sur un serveur FTP et effacés localement juste après l’envoi. 
	- Possible de spécifier le type de log et le moment de l’envoi.
	![[Pasted image 20240923121542.png]]
	