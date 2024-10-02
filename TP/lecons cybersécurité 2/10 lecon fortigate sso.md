# Tache 2 : Synthese

1. Principe du Single Sign-On (SSO) :

Le SSO (Single Sign-On) permet aux utilisateurs d'accéder à plusieurs ressources après une seule authentification initiale, sans avoir à ressaisir leurs identifiants pour chaque service. Cela améliore l’expérience utilisateur et renforce la sécurité en centralisant l'authentification .
2. Serveurs d’authentification utilisés avec Fortinet SSO :

    Active Directory (AD).
    NTLM pour les environnements Microsoft.
    eDirectory pour les environnements Novell.
    Serveur RADIUS via FortiAuthenticator, qui peut remplacer un agent de collecte SSO dans un réseau Windows AD .

3. Modes de déploiement du SSO avec Windows AD :

    Mode agent du contrôleur de domaine (DC agent mode).
    Mode polling.
    Mode agent serveur Terminal (TS agent mode) .

4. Caractéristiques des modes de déploiement du SSO avec Windows AD :

    DC agent mode : Installe un agent sur chaque contrôleur de domaine (DC) pour surveiller les connexions des utilisateurs, puis envoie les informations à un agent collecteur. Ce mode nécessite un redémarrage des DC après l'installation.
    Polling mode : Ne nécessite pas d’agent sur les DC. L'agent collecteur interroge les DC à intervalles réguliers. Il existe deux variantes : avec agent collecteur ou sans agent (agentless).
    TS agent mode : Utilisé pour les environnements Citrix et Terminal Services, avec un agent collecteur ou un FortiAuthenticator .

5. Caractéristiques des modes de polling (mode avec agent) :

    WMI (Windows Management Instrumentation) : Requêtes optimisées qui ne renvoient que les événements de connexion nécessaires.
    WinSecLog : Interroge directement le journal des événements du DC, ce qui peut entraîner une latence.
    NetAPI : Méthode la plus rapide, interroge la table des sessions en RAM, mais certaines sessions peuvent être manquées si elles sont rapidement créées et supprimées .

6. Utilisation du NTLM et conditions requises :

Le NTLM (NT Lan Manager) est utilisé lorsque l'authentification transparente n'est pas possible ou en tant que solution de secours pour FSSO. Il est souvent utilisé dans des configurations de domaines simples. Pour fonctionner, NTLM nécessite un navigateur compatible, tel qu'Internet Explorer .
7. Caractéristiques des deux modes d’accès à l’AD :

    Mode standard : Utilise le format NetBIOS (Domain\username). Ne prend pas en charge les groupes imbriqués et les profils de sécurité ne peuvent être appliqués qu'aux groupes d’utilisateurs.
    Mode avancé : Utilise la convention LDAP (CN=User,OU=Name,DC=Domain). Il permet l'application de profils de sécurité aux groupes imbriqués et un filtrage plus précis des groupes .