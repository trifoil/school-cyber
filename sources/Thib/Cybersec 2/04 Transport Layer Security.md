#Cybersec_2_index 
[[Cybersec_2_index]]
___

### VPN d'accès à distance
- Communications sécurisées entre les télétravailleurs et l'entreprise
	- assurer la confidentialité, l'intégrité, l'authentification et l'anti-rejeu
	- droits d'accès adaptés selon les utilisateurs
- Déploiement d'un VPN d'accès à distance
	- Via le protocole SSL (VPN SSL)
		- Permet la connectivité à partir de périphérique BYOD
		- Peu, voir pas de maintenance logicielle
		- Portails Web personnalisés pour les utilisateurs à l'ouverture d'une session.
	- Via le protocole IPsec (VPN IPsec
		- D'un point de vue sécurité (Puissance du chiffrement et de l'authentification), IPsec est meilleur que SSL. 
		- Le VPN IPsec prend en charge un plus grand nombre d'applications que le VPN SSL.

### SSL et TLS
- Secure Socket Layer
	- Développé initialement par Netscape pour protéger les échanges sur Internet. 
	- A l'époque, norme imparfaite et non normalisée.
- Transport Layer Security
	- L'IETF a poursuivi le développement de SSL
		- En le rebaptisant TLS pour des questions de droits. 
		- Fonctionne en mode client-serveur. 
		- Norme actuelle = TLS 1.2
	- TLS est un ensemble de protocoles de sécurisation des échanges
		- Il permet d'authentifier le serveur et le client. 
		- Il permet de chiffrer les données. 
		- Il permet de vérifier l'intégrité des données. 
		- Il permet d'empêcher le rejeu.
	![[Pasted image 20240928175234.png]]
	![[Pasted image 20240928175249.png]]

### TLS est transparent pour l'utilisateur
- Comment savoir si l'on se connecte à un site sécurisé?
![[Pasted image 20240928175326.png]]

### Reconnaitre un site sécurisé avec TLS
![[Pasted image 20240928175709.png]]

### Let's Encrypt (LE)
- Autorité de certification (depuis 2015)
	- Plus de 10 millions de certificats ont été délivrés après seulement un an
- Peut fournir des certificats gratuits X.509
	- Pour la sécurisation des sites Internet avec TLS.
- Tout est automatisé
	- Création, validation, signature, installation et renouvellement des certificats, ….

### Niveaux de validations des certificats
- Domain Validated (DV) 
- Organization Validated (OV) 
- Extended Validation (EV)

### WHOIS
- Service de recherche
	- Permet d'obtenir des informations sur une adresse IP ou un nom de domaine.
	![[Pasted image 20240928175945.png]]

### Domain Validated (DV SSL)
- Avantages
	- Certificat bon marché et délivré rapidement (automatisé
- Inconvénients
	- La CA vérifie uniquement que le propriétaire du nom de domaine est le demandeur du certificat
		- Vérification généralement par envoi d'un e-mail à l'adresse trouvée dans le WHOIS. 
		- Ne garanti pas l'identité du propriétaire du site Web ni même l'existence de l'organisation/entreprise
	- Une attaque par phishing est possible. Un pirate peut :
		- Faire enregistrer www.belflus.be (un L au lieu du i). 
		- Fournir de fausses informations au WHOIS (adresse gmail, numéro de téléphone VoIP, …). 
		- Créer un faux site ressemblant à celui de la banque.
		-> le pirate aura un faux site similaire au site de Belfius, avec une URL très similaire et un certificat valide

### Domain Validated (DV)
- Vérification du type de certificat
![[Pasted image 20240928180415.png]]

### Organization Validated (OV SSL)
- Ils garantissent la légitimité de l'organisation
	- Ils "activent" le protocole https, ainsi que le cadenas sur les navigateurs. 
	- L’identité de l'entreprise est affichée sur les navigateurs, prouvant que le site est légitime.

### Extended Validation (EV SSL)
- Appelé aussi High-Assurance Certificate
	- Ils "activent" le protocole https, le cadenas et la barre d'adresse verte.
- Haut niveau de vérification
	- Vérification du droit exclusif d'utilisation du nom de domaine. 
	- Vérification de l'accord de l'organisation pour l'émission du certificat. 
	- Vérification de l'existence légale, physique et opérationnelle de l'organisation. 
	- Vérification de l'exactitude des informations transmises (adresse, n° de téléphone), etc

### Afficher les certificats
![[Pasted image 20240928180638.png]]
![[Pasted image 20240928180650.png]]

### Algorithme de chainage
- Algorithmes symétriques
	- Ils utilisent toujours la même clé et chiffrent des petits blocs de données : il y a risque de chiffrer plusieurs fois les mêmes blocs
	- En chiffrant toujours avec la même clé, il y a plus de risques qu'un pirate arrive à retrouver les clés (voir méthodes de cryptanalyse).
- Algorithme de chainage.
	- Ces algorithmes permettent de s'assurer que des chiffrements distincts sont produits même lorsque le même texte est chiffré plusieurs fois avec la même clé.
	- Exemples d'algorithmes (CBC : Cipher Block Chaining, GCM : Galois/Counter Mode, EBC : Electronic Codebook)
![[Pasted image 20240928181018.png]]

### Attributs du certificat
![[Pasted image 20240928181052.png]]![[Pasted image 20240928181102.png]]
![[Pasted image 20240928181114.png]]
![[Pasted image 20240928181123.png]]
![[Pasted image 20240928181136.png]]

### Chaine de certificats
![[Pasted image 20240928181144.png]]
![[Pasted image 20240928181215.png]]

### Pourquoi une chaine de certificats ?
- Le navigateur doit pouvoir vérifier le certificat que le serveur lui envoie
	- Le certificat du serveur contient la signature de la CA (signé avec la clé privée de la CA). 
	- Si le client parvient à déchiffrer la signature du certificat avec la clé publique de la CA, le certificat est authentique.
- Certains certificats sont intégrés aux navigateurs
	- La clé publique de la CA se trouve dans un de ces certificats intégrés
		- Pour que le navigateur puisse authentifier le certificat du serveur, il doit avoir le certificat de la CA contenant la clé publique de la CA. 
		- Tous les certificats de toutes les CA et RA ne sont pas intégrés aux navigateurs.
			» Les certificats des CA racines pourraient suffire
	- Au niveau mondial
		- Si une CA veut vendre des certificats au niveau mondial, ceux-ci vont se retrouver sur des milliers de machines à travers le monde.
- Et si une CA racine perd sa clé privée?
	- Si une CA racine perd ou se fait voler sa clé privée, il faut aller sur tous les navigateurs du monde pour modifier le certificat ! 
	- Pour cette raison, la clé privée de la CA racine est utilisée une seule fois puis placée en sécurité
- Autorité intermédiaire
	- Avant de la mettre « au coffre » :
		- On utilise la clé privée de l'autorité racine pour signer la paire de clé d'une autorité intermédiaire : l'autorité d'enregistrement. 
		- C'est cette nouvelle paire de clés de la RA qui va signer tous les certificats des serveurs.
	- Si les clés de la RA sont compromises :
		- On répudie le certificat de la RA. 
		- On ressort la clé privée de la CA root de son coffre et on signe une nouvelle RA.
		→ On n'a pas du aller modifier tous les navigateurs car on garde la même CA root en qui on a toujours confiance

### Organisation d'une PKI
	![[Pasted image 20240928182829.png]]

### Afficher les certificats connus du navigateur (Firefox)
![[Pasted image 20240928182844.png]]
![[Pasted image 20240928182910.png]]

### Usage des certificats
- Exemple n°1 : le certificat du serveur www.belfius.be
![[Pasted image 20240928182938.png]]
- Exemple n°2 : le certificat de la RA
![[Pasted image 20240928182951.png]]

### Certification Practice Statement (CPS)
- La politique de certification (CPS) est un document reprenant l'ensemble des règles que suit l'autorité d'enregistrement pour ses prestations.
![[Pasted image 20240928183013.png]]

### OCSP
![[Pasted image 20240928183029.png]]

### Répondeur OCSP
- Problème
	- La validation des certificats est généralement faite par les clients PKI
		- Le client va vérifier dans le "Directory" la liste actualisée des certificats révoqués
	- Les clients ne gèrent pas toujours cette validation correctement
		- Par exemple, la mise à jour des informations des CRL n'est pas automatisée. 
		- Les navigateurs ne disposent donc pas toujours d'une liste correcte des certificats révoqués.
- Online Certificate Status Protocol
	- Protocole utilisé pour vérifier la validité d'un certificat numérique X.509 
		- OCSP permet de centraliser les CRL au sein d'une PKI. 
		- Le client communique alors avec qu'avec une seule entité.
	- Standard IETF (RFC 6960)
- Répondeur OCSP
	- Comme les serveurs OCSP répondent aux requêtes clients, ils sont appelés répondeurs OCSP.

### OCSP Stapling
- Inconvénients d'OCSP
	- Cela ajoute de la latence aux connexions HTTPS
		- Il faut une connexion supplémentaire vers l'autorité de validation afin de vérifier le certificat. 
		- Cela peut bloquer l'accès au site si le répondeur OCSP ne répond pas.
	- Peut être considéré comme une fuite d'informations 
		- Vous indiquez au répondeur OCSP les sites que vous visitez, ce qui peut être dommageable en termes de respect de la vie privée.
- L’agrafage OCSP
	- Principe 
		- Le serveur HTTPS va lui même fournir une réponse OCSP, directement lors de la négociation TLS (handshake).
			» Il va agrafer cette réponse OCSP aux informations échangées lors de la phase de handshake TLS. 
			» Ce n'est donc plus au client d'effectuer le contrôle de validité
		- La réponse OCSP agrafée par le serveur est fiable car elle est horodatée (donc non périmée) et signée par la CA.
	- Le navigateur doit être compatible OCSP stapling

### Qualys SSL Labs
- Documentations et outils
	- Nombreux conseils pour gérer la sécurité de son site Web. 
	- Des outils permettent de vérifier son site Web ainsi que son navigateur.
- Exemple de vérification d'un navigateur
	![[Pasted image 20240928183357.png]]
	![[Pasted image 20240928183412.png]]
	![[Pasted image 20240928183422.png]]![[Pasted image 20240928183430.png]]
	![[Pasted image 20240928183446.png]]
- Exemple de vérification d'un site Web ne supportant pas HTTPS
	- Résultat du test effectué en aout 2017
	![[Pasted image 20240928183503.png]]
- Exemple moins sécurisé
	- Résultat du test effectué en octobre 2018
	![[Pasted image 20240928183549.png]]
	- Résultat du test effectué en février 2023
	![[Pasted image 20240928183613.png]]
	![[Pasted image 20240928183624.png]]
- Exemple de vérification d'un site Web
	- L'outil permet de vérifier la négociation du certificat, la négociation du protocole, l'échange de clé et la force du chiffrement.
	![[Pasted image 20240928183645.png]]
	![[Pasted image 20240928183702.png]]
	![[Pasted image 20240928183716.png]]
	![[Pasted image 20240928183729.png]]
	![[Pasted image 20240928183737.png]]
	![[Pasted image 20240928183746.png]]

### HTTP Strict Transport Security (HSTS)
- HSTS doit être activé sur le site Web
	- Permet à un serveur web de signifier au navigateur web compatible, qu'il doit obligatoirement être contacté en HTTPS.
- Strict
	- Si la sécurité de la connexion n'est pas garantie (certificat auto-signé), l'utilisateur ne peut accéder au site.
- Liste de pré-préchargement pour les pages HTTPS
	- Chaque première visite d’un site est vulnérable aux attaques (SSL stripping). 
	- HSTS ne fonctionne que si un site Internet a été consulté au moins une fois dans le passé via une connexion HTTPS non manipulée. 
	- Les navigateurs populaires utilisent aujourd’hui des listes basées sur un service de pré-chargement pour HSTS.
		- https://hstspreload.org/
	![[Pasted image 20240928183957.png]]