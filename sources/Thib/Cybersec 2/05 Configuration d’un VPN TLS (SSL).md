#Cybersec_2_index 
[[Bac_3_Index]]
___

### VPN SSL
- Utilisé notamment pour sécuriser les transactions Web
	- Basé sur un tunnel HTTPS
- Utilisé pour accéder à des ressources internes
	- Les clients doivent s'authentifier sur une page Web : le portail VPN-SSL
### VPN IPsec
- Pour n’importe quelle application client-serveur. 
- Plutôt utilisé pour les VPN de site à site. 
- Compatible avec d'autres matériel que FortiGate
![[Pasted image 20241001170624.png]]
![[Pasted image 20241001170641.png]]

### 1. Mode tunnel
- Nécessite l'utilisation d'un client VPN (FortiClient ou FortiSSL)
	- Un adaptateur réseau virtuel nommé "fortissl" est créé sur le poste client. 
	- L'UTM assigne dynamiquement une adresse IP routable à l'adaptateur virtuel.
- Deux modes de connexion
	- Soit via connexion au portail VPN-SSL 
	- Sur la page du portail, on aura alors la possibilité d'activer le tunnel VPN. • Soit directement depuis le FortiClient sans passer par le portail
- Accès direct aux ressources 
	- En mode tunnel 
		- L'utilisateur sera "directement connecté" (pas de proxy) au réseau où se trouvent les ressources de l'entreprise. 
		- L'utilisateur aura donc potentiellement accès à toutes les ressources de ce réseau comme s'il était lui-même physiquement connecté à ce réseau. 
	- N'importe quelle application IP peut transmettre des données via le tunnel

### Mode tunnel : Split tunneling
- Désactivé
	- Tout le trafic du client est routé via le tunnel VPN SSL, y compris le trafic Internet.
	- Le FortiGate devient la passerelle par défaut des hôtes
- Activé
	- Le trafic du client destiné au réseau privé est routé via le tunnel VPN-SSL. 
	- Le trafic vers Internet est routé localement
	![[Pasted image 20241001171945.png]]

### Mode tunnel : FortiGate en tant que client VPN SSL
- Possible depuis FortiOS 7
	- Un FortiGate peut être configuré comme un client VPN SSL, en utilisant une interface de type SSL-VPN Tunnel. 
	- Permet aux appareils connectés au FortiGate client d’accéder aux ressources situées derrière le FortiGate serveur via un tunnel VPN SSL.
- Avantages
	- Tunnel entre deux FGT → Autorise des topologies Hub and spoke en VPN SSL. 
	- Utile lorsqu’un tunnel IPsec ne peut être établi 
		- Le protocole ESP est bloqué. 
		- Les ports UDP 500 ou 4500 sont bloqués. 
		- Problèmes de fragmentation IKE.
- Inconvénient
	- Nécessite l'installation d'un certificat sur le FortiGate serveur.

### 2. Mode Web-only
- L'utilisateur distant doit se connecter au portail VPN-SSL du FortiGate
	- Une fois authentifié et connecté l'utilisateur a accès uniquement aux ressources disponibles via le portail
		- Soit via des bookmarks (liens). 
		- Soit via des widgets
- Le portail va donner accès aux ressources en mode reverse proxy
	- Pas un accès direct aux ressources. 
	- Supporte un nombre limité de protocoles 
		- HTTP(S), FTP, SMB/CIFS, SSH,VNC, ping, RDP, citrix, Port Forward. 
	- Nécessite un navigateur Web et que la page du portail reste ouverte
		![[Pasted image 20241001172527.png]]

### Étapes de configuration (FortiGate en serveur VPN SSL)
- Configurer les comptes utilisateur et les groupes 
	- Il faudra s'authentifier pour accéder au VPN. 
- Configurer le portail-VPN (SSL VPN Portals) 
	- Nécessaire en mode Web-only. 
- Configurer les paramètres de connexion au VPN (SSL VPN settings) 
	- Quel timeout, quelle authentification est requise, … 
- Créer une règle de pare-feu pour autoriser l'accès aux ressources 
	- Pour accepter et déchiffrer les paquets de l'interface VPN. •
	- Généralement pour permettre l'accès au réseau interne. 
- (Optionnel) Créer une règle de pare-feu pour router le trafic vers Internet 
	- Lorsque le split tunneling est désactivé, une règle de pare-feu doit autoriser le trafic du client vers Internet en passant par l'UTM. 
	- L'UTM peut être utilisé pour appliquer des profils de sécurité.

### Authentification pour l'accès au VPN
- Authentifications supportées par le VPN SSL 
	- Compte local. 
	- Compte distant (LDAP, RADIUS, …). 
	- Authentification à un ou deux facteur (FortiToken + Login/mot de passe) 
- Authentification FSSO non supportée 
	- L'authentification distante Fortinet Single Sign-On (FSSO) ne peut pas être utilisée pour l'authentification VPN. 
- Rappel 
	- Conflit par défaut : administration du FW et portail utilisent le port 443 
		- Uniquement si les deux utilisent le même port sur la même interface 
		- En cas de conflit, seul le login au portail VPN SSL apparaitra.

### 1. Création d'un utilisateur local
![[Pasted image 20241001173300.png]]

### Création d'un groupe d'utilisateurs
- Create new → donner un nom au groupe. 
- On assigne l'utilisateur voulu comme membre de ce groupe.
	![[Pasted image 20241001173332.png]]

### 2. Configuration du portail
![[Pasted image 20241001173627.png]]

### SSL-VPN Portals
- Portail 
	- Un portail est une page Web contenant des outils et des liens vers des ressources. 
	- Les utilisateurs peuvent accéder aux ressources en utilisant ces outils et ces liens.
- Configuration d'un portail 
	- Un portail peut être paramétré pour 
		- Définir ce que l'utilisateur distant voit comme ressources disponibles. 
		- Être lié à un utilisateur ou à un groupe d'utilisateurs spécifique afin qu'il n'ait accès qu'aux ressources requises. 
		- Définir le mode d'accès : mode Web-only, mode tunnel ou les deux. 
		- Fournir l'historique de connexion
	- L'administrateur et l'utilisateur ont tous les deux la possibilité de personnaliser le portail VPN SSL

### SSL-VPN Portals
![[Pasted image 20241001173939.png]]
![[Pasted image 20241001174031.png]]

### Configurer un portail Web
![[Pasted image 20241001174149.png]]

### Realms and bookmarks
- Configuration par défaut 
	- Par défaut, tous les utilisateurs verront le même portail : les mêmes signets, le même thème, … 
- Afficher les rubriques de configuration 
	- Les rubriques pour configurer d'autres signets et domaines sont masquées par défaut
	![[Pasted image 20241001174312.png]]

### Realms
- Les domaines sont des pages de connexion personnalisées
	- Généralement pour des groupes d'utilisateurs mais possible aussi pour un utilisateur unique. 
- Donnent accès à différents portails en fonction de l'URL saisie par l'utilisateur 
	- Par exemple, vous pouvez créer des portails différents selon les départements 
		- https://10.0.1.254:/marketing 
		- https://10.0.1.254:/accountants 
		- https://10.0.1.254:/administratif
	![[Pasted image 20241001174404.png]]

### Bookmarks
- Ce sont des liens vers des ressources réseau 
	- Ils sont affichés dans le portail. 
	- Une fois connecté sur le portail, l'utilisateur n'a plus qu'à cliquer sur le liens pour lancer l'application souhaitée. 
- Predefined Bookmarks 
	- Permet à l'administrateur de créer des signets pour les utilisateurs.
	![[Pasted image 20241001174450.png]]
- Une fois le signet créé par l'administrateur
	→ Il est affiché dans la page de configuration.
	![[Pasted image 20241001174526.png]]
	→ Il est visible sur le portail
	![[Pasted image 20241001174544.png]]
- User Bookmarks
	- Donner la possibilité aux utilisateurs de pouvoir créer leurs propres bookmarks. 
		- L'option User Bookmarks doit être activée dans VPN > SSL-VPN Portals.
	- Nécessite une certaine connaissance informatique de la part de l'utilisateur
	![[Pasted image 20241001174628.png]]
### Exemple de portail
![[Pasted image 20241001174651.png]]
![[Pasted image 20241001174859.png]]
- Si le mode tunnel a été activé, on retrouve une rubrique "Tunnel Mode" sur le portail
	![[Pasted image 20241001174930.png]]

### 3. SSL-VPN Settings
![[Pasted image 20241001175302.png]]

### Connection Settings
-  Restrict Access
	- Permet de restreindre l'accès à certains hôtes spécifiques 
		- Tous les utilisateurs n'ont pas nécessairement besoin de se connecter en VPN SSL. 
		- On peut refuser l'accès pour des raisons de sécurité (par ex. sur base géographique). 
	- Ces hôtes doivent avoir été définis dans Policy & Objects
	![[Pasted image 20241001175800.png]]

### Tunnel mode client settings
-  Address Range 
	- Défini quelles adresses seront données aux clients qui vont se connecter. 
	- L'étendue d'IP va définir le nombre d'utilisateurs qui pourront se connecter simultanément. 
- DNS Server 
	- Adresse du server DNS qui sera donné au client lorsque le mode tunnel est activé. 
	- Généralement utilisé si le split tunneling est désactivé.
![[Pasted image 20241001175841.png]]

### Authentication/Portal Mapping
- Création de règles
	- Elles permettent d'associer un portail et/ou un domaine à des utilisateurs/groupes. 
	- Seuls les utilisateurs/groupes spécifiés auront accès à ce portail.
- All Other Users/Groups
	- Règle par défaut qui s'applique au domaine racine. 
		- Permet de définir un portail qui ne contient que de l'information (pas d'accès à des ressources) à destination des utilisateurs qui ne sont pas associé à un portail. 
	- La règle ne peut pas être supprimée.
	![[Pasted image 20241001180016.png]]

### Fin de la configuration
- Message WARNING 1
	- Certificat autosigné 
		- Avec un certificat autosigné, l'utilisateur qui essaiera de se connecter sur le portail VPN SSL avec un navigateur Web va recevoir un avertissement. 
	- Message d'avertissement 
		- Si l'on n'utilise pas de certificat numérique signé par une autorité de certification (CA) connue, le FortiGate s'en rend compte et demande une confirmation.
	![[Pasted image 20241001180053.png]]
- Message WARNING 2
	- Configuration incomplète 
		- Le FortiGate nous signale que la configuration n'est pas finie. 
		- Il reste à paramétrer une règle de sécurité pour l'accès aux ressources.
		![[Pasted image 20241001180143.png]]

### 4. Autoriser l'accès aux ressources internes
![[Pasted image 20241001180324.png]]

### 5. Autoriser l'accès à Internet
- Une autre règle est nécessaire pour permettre l'accès à Internet lorsque le split tunneling est désactivé
![[Pasted image 20241001180347.png]]

### Configurer les profils de sécurité
- Le cas échéant, configurer et activer les fonctions de sécurité de l'UTM
	![[Pasted image 20241001180532.png]]

### FortiGate en tant que client SSL-VPN
1. Importer le certificat pour l’authentification. 
2. Créer une interface de type tunnel (Network > Interface > Create new). 
3. Configurer les paramètres client VPN SSL (VPN > SSL-VPN client). 
4. Créer la règle de pare-feu.
	![[Pasted image 20241001180712.png]]

### Hardware Acceleration for SSL-VPN
- Activer ou désactiver l'accélaration matérielle
	- Par défaut, le traffic SSL-VPN est déchargé vers des processeurs CP8 ou CP9. 
	- Uniquement sur les modèles disposant de processeurs CP8 ou CP9
```
config firewall policy 
	edit 1 
	set auto-asic-offload [enable |disable] 
end
```
- Afficher le status de l'accélération matérielle
	![[Pasted image 20241001180840.png]]

### Client Integrity Checking (mode tunnel uniquement)
- Le FortiGate vérifie l'intégrité du client
	- Détecte, sur la machine cliente, les applications de sécurité reconnues par le centre de sécurité Windows (A-V et FW). 
		- Donc uniquement compatible avec les clients Microsoft Windows. 
		- Vérification de l'état des applications 
			» Actif/inactif, numéro de version, signatures à jour.
- Caractéristiques
	- Le Client Integrity Check a lieu juste après la phase d'authentification. 
		- Si la vérification échoue, la connexion VPN est refusée. 
	- La vérification peut être activée séparément pour chaque portail. 
	- Compatible avec le mode Web et le mode tunnel.

### Client Integrity Checking (cont.)
- Inconvénient
	- Peu générer une charge de travail supplémentaire aux administrateurs 
		- Tous les logiciels des PC clients doivent être à jour. 
	- Nécessite une bonne connaissance du fonctionnement des OS Windows 
		- Les mises à jour logicielles peuvent entraîner une modification des valeurs de la clé de registre empêchant les utilisateurs de se connecter au VPN
- Client Integrity Checking configuration
	- L'activation et la configuration se font uniquement en CLI.
```
#config vpn ssl web portal 
	edit <portal_name> 
		set host-check {none | av | fw | av-fw | custom}
		set host-check-interval <seconds> 
end
```

### Client Integrity Checking configuration
- On entre dans le menu correspondant au portail web VPN SSL
	![[Pasted image 20241001181109.png]]

### On peut alors choisir ce que l'on souhaite que le FortiGate vérifie
![[Pasted image 20241001181125.png]]

### Client Integrity Checking
- Afficher la liste des logiciels de sécurité compatibles
```
FGT# config vpn ssl web host-check-software 
show
```
![[Pasted image 20241001181155.png]]

### Autres options de sécurité
- Require Client Certificate 
	- Obligation pour les clients de fournir un certificat. 
		![[Pasted image 20241001181245.png]]
- Imposer Forticlient 
	- Impose aux utilisateurs d'installer Forticlient pour continuer. 
	- Les utilisateurs ont la possibilité, via de portail, de télécharger le logiciel Forticlient 
		- Ils peuvent ainsi l'installer avant de poursuivre le processus d'authentification et de connexion au VPN SSL
- Imposer l'authentification à deux facteurs
- Autoriser uniquement certaines adresse IP
	- Voir l'option "Restrict Access" dans la rubrique "Connection Settings"
```
config vpn ssl setting
	set source-address-negate [enable|disable] 
	set source-address6-negate [enable|disable] 
end
```
	![[Pasted image 20241001181308.png]]
- Refuser certaines adresse IP (CLI only)
```
config vpn ssl setting
	set source-address-negate [enable|disable] 
	set source-address6-negate [enable|disable] 
end
```

### Minuteurs SSL-VPN
- Problèmes de déconnexion
	- Si la latence est importante sur le réseau, FortiGate peut déconnecter le client
		- Le minuteur pourrait expirer avant que l'utilisateur ne puisse terminer les processus de négociation (Temps de résolution DNS, temps pour entrer un token, …).
![[Pasted image 20241001181442.png]]

### Dashboard > Network > SSL VPN
- Permet de vérifier quel utilisateur d'un VPN SSL est connecté ainsi que l’état du tunnel. 
- Les logs sont affichés dans Log & Report > System Events.
![[Pasted image 20241001181504.png]]
### Déconnexion VPN
- La session d'authentification de la règle de pare-feu est associée à la session du tunnel VPN SSL
	- Lorsqu'un VPN SSL est déconnecté toutes les sessions associées dans la table de sessions sont supprimées. 
		- Peu importe que la déconnexion ait lieu par l'utilisateur ou via le paramètre d'inactivité du VPN SSL (Idle timeout), 
	- Cela empêche la réutilisation des sessions VPN SSL authentifiées
![[Pasted image 20241001181539.png]]

### SSL-VPN logs
- Permet de vérifier quel utilisateur d'un VPN SSL est connecté
![[Pasted image 20241001181611.png]]
