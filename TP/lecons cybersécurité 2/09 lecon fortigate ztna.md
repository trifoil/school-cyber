# Tache 2 : Synthese

1. Principe du modèle Zéro Confiance (Zero Trust) :

Le modèle Zéro Confiance repose sur le principe "ne jamais faire confiance, toujours vérifier". Il considère qu'aucun utilisateur ou terminal n'est digne de confiance, même s'il est à l'intérieur du réseau de l'entreprise. Chaque tentative d'accès doit être authentifiée et autorisée, en vérifiant en permanence les identités et la sécurité des terminaux​.

2. 7 principes de l'architecture Zero Trust (ZTA) selon le NIST :

    - Toutes les ressources (données, services, équipements) doivent être considérées comme sensibles.
    - Toutes les communications doivent être sécurisées, quel que soit l'emplacement des ressources.
    - Chaque tentative d'accès doit être vérifiée et contrôlée en fonction des autorisations définies.
    - Les accès doivent être soumis à une politique dynamique, s'adaptant au contexte.
    - Un système de surveillance continue de l'intégrité et de la sécurité doit être mis en place.
    - Les mécanismes d'authentification et d'autorisation doivent être dynamiques et strictement appliqués.
    - Une supervision constante de la sécurité du réseau est nécessaire​.

3. Trois caractéristiques de la solution Fortinet ZTNA :

    - Vérification de l’identité des périphériques via des certificats.
    - Authentification multifacteur (MFA) pour les utilisateurs.
    - Contrôle de la posture de sécurité basé sur le contexte (ex. : présence d’un antivirus, certificat, etc.)​.

4. Cinq exemples de contrôles de posture basés sur le contexte via des étiquettes ZTNA :

    - Localisation géographique.
    - Présence d'un antivirus à jour.
    - Connexion à FortiClient EMS.
    - Version spécifique de l’OS.
    - Connexion à un domaine Active Directory (AD)​.

5. Deux modes Fortinet ZTNA et leur utilisation :

    - ZTNA Access Proxy : Utilisé pour permettre aux utilisateurs d’accéder aux ressources via un proxy en SSL, généralement pour des applications web, - SSH ou RDP. Pratique pour l'accès distant sans avoir besoin d'un VPN.
    - ZTNA IP/MAC Filtering : Utilisé dans un réseau interne (on-net) pour combiner des règles d'accès IP/MAC avec des étiquettes ZTNA. Ce mode ne nécessite pas l'utilisation d'un proxy​.

6. Principe de fonctionnement du Fortinet ZTNA (EMS/FortiClient/FortiGate) :

    - FortiClient EMS configure les règles ZTNA et les synchronise avec FortiClient et FortiGate.
    - FortiClient s'enregistre et partage l'état du périphérique via des télémétries ZTNA.
    - FortiGate utilise ces informations pour appliquer les règles de contrôle d’accès, basées sur des étiquettes (tags) et le contexte du périphérique​.

7. Événements déclenchant une vérification des sessions actives :

    - Changements de posture des terminaux (par ex. : si un appareil devient non conforme).
    - Modifications des règles ZTNA, entraînant une nouvelle vérification de la conformité des sessions​.

8. Caractéristiques du ZTNA sans client :

    - Utilise un proxy inverse sans besoin d'installer un agent sur les terminaux.
    - Prend en charge uniquement les applications HTTP/HTTPS.
    - Offre moins de visibilité et de contrôle qu'un ZTNA avec client​.

9. Comparaison ZTNA et VPN :

    - ZTNA fournit un accès par session, avec des permissions granulaires basées sur l'identité et la posture du terminal. Il offre également une meilleure visibilité sur les actions des utilisateurs et réduit les risques de mouvement latéral dans le réseau grâce à la micro-segmentation.
    - VPN donne un accès plus large, souvent à tout un réseau, sans vérifier l'état des appareils après la connexion. Il introduit plus de latence et une moindre flexibilité en termes de gestion et de surveillance​.