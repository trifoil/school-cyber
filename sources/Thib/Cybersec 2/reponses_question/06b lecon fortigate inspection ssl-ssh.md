# Tache 2 : Synthese

1. **Utilité de l’inspection SSL-SSH** :

    L’inspection SSL-SSH permet de déchiffrer le trafic chiffré pour l’analyser et appliquer des politiques de sécurité telles que l'antivirus, le filtrage web, ou la détection d'intrusion. Cela est essentiel car les pirates peuvent cacher des malwares dans des communications SSL/TLS ou SSH​.

2. **Les deux méthodes d’inspection SSL-SSH** :

    - SSL Certificate Inspection
    - Full SSL Inspection (Deep Inspection)​
​
3. **Caractéristiques des deux méthodes d’inspection SSL-SSH** :

- SSL Certificate Inspection :
    - Vérifie uniquement la validité des certificats SSL sans déchiffrer le contenu du trafic.
    - Utilise moins de ressources et de latence.
    - Appliquée lorsque seul le filtrage Web est nécessaire.

- Full SSL Inspection :
    - Offre une protection plus complète en déchiffrant tout le trafic pour appliquer les politiques de sécurité.
    - Introduit plus de latence et consomme plus de ressources, mais permet une analyse approfondie des contenus (antivirus, contrôle des applications, etc.).


4. **Vérifications du FortiGate lors de l’inspection d’un certificat** :

    Le FortiGate vérifie :
    - La date de validité du certificat.
    - La signature numérique du certificat.
    - Si le certificat a été révoqué en consultant les CRL (Certificate Revocation List) ou via OCSP.
    - Si le certificat est émis par une autorité de certification (AC) valide​​.