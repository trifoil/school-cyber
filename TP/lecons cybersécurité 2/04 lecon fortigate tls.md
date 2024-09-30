
1. **Protocole utilisé par un VPN SSL** :
   Le protocole utilisé est **SSL/TLS** (Transport Layer Security), souvent appelé VPN SSL, qui permet de sécuriser les communications à distance entre des utilisateurs et une entreprise via un tunnel HTTPS【7:0†source】【7:15†source】.

2. **Niveaux de validation des certificats** :
   - **DV (Domain Validated)** : Ce certificat vérifie uniquement que le propriétaire du nom de domaine est le demandeur, souvent utilisé pour les sites ne traitant pas de données sensibles.
   - **OV (Organization Validated)** : Ce certificat garantit l'authenticité de l'organisation, idéal pour les entreprises.
   - **EV (Extended Validation)** : C'est le niveau le plus élevé, avec une validation approfondie de l'organisation, utilisé pour les sites nécessitant une haute assurance (comme les banques)【7:4†source】【7:5†source】.

3. **Comment savoir le niveau de validation d’un certificat de serveur Web ?** :
   Il est possible de le déterminer via des indicateurs visuels dans le navigateur, comme un cadenas pour les certificats OV et une barre verte pour les certificats EV, ou en inspectant les attributs du certificat affichés dans le navigateur【7:5†source】【7:4†source】.

4. **Utilité d’un algorithme de chaînage** :
   Un algorithme de chaînage permet de chiffrer des blocs de données de manière séquentielle afin d'assurer que le chiffrement de blocs identiques avec la même clé génère des résultats différents, ce qui renforce la sécurité【7:12†source】.

5. **Utilité du standard PKCS** :
   Le **PKCS (Public-Key Cryptography Standards)** accélère le déploiement de la cryptographie à clé publique en définissant des normes de stockage et d'échange de certificats【7:12†source】.

6. **Infrastructure à clés publiques (PKI)** :
   Une PKI est un ensemble de technologies, procédures et logiciels qui permet de gérer le cycle de vie des certificats numériques de manière sécurisée. Elle inclut des entités comme les CA (autorités de certification) et les RA (autorités d'enregistrement)【7:1†source】【7:6†source】.

7. **Service WHOIS** :
   Le WHOIS est un service de recherche permettant d’obtenir des informations déclaratives sur une adresse IP ou un nom de domaine【7:4†source】.

8. **Certification Practice Statement (CPS)** :
   Le CPS est un document décrivant les règles suivies par une autorité d'enregistrement pour l'émission de certificats. Il peut être trouvé dans les informations du certificat lui-même【7:3†source】.

9. **Utilité du protocole OCSP** :
   Le **OCSP (Online Certificate Status Protocol)** permet de vérifier en temps réel la validité d'un certificat X.509, en communiquant avec une entité centralisée appelée répondeur OCSP【7:3†source】.

10. **Utilité de l’agrafage OCSP** :
    L’agrafage OCSP permet au serveur de fournir directement la réponse OCSP lors de la négociation TLS, ce qui évite au client d’interroger directement le répondeur OCSP, réduisant ainsi la latence【7:3†source】.

11. **Outil pour tester la configuration d’un serveur SSL** :
    **Qualys SSL Labs** est un outil populaire pour vérifier la configuration SSL d'un serveur web et s'assurer de sa sécurité【7:3†source】【7:7†source】.