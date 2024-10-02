# Tache 2 : Synthese

1. Problèmes ou inconvénients résolus par le SD-WAN :

Le SD-WAN résout plusieurs problèmes liés à la gestion des réseaux WAN traditionnels, tels que :

    Optimisation du routage : Permet de sélectionner automatiquement les chemins réseau en fonction de la qualité des liens, ce qui améliore la performance des applications critiques.
    Haute disponibilité : Assure la continuité des services en basculant automatiquement entre les différents liens WAN.
    Équilibrage de charge : Répartit intelligemment le trafic réseau sur plusieurs connexions WAN pour éviter la surcharge sur une seule ligne​.

2. Méthodes d’équilibrage de charge dans le SD-WAN :

Les méthodes d’équilibrage de charge utilisées entre les interfaces membres du SD-WAN incluent :

    Source IP : Les sessions provenant d’une même adresse IP source sont dirigées vers la même interface.
    Source-destination IP : Les sessions avec une même paire d’IP source et destination utilisent la même interface.
    Spillover (Usage) : Le trafic utilise une interface jusqu’à atteindre un seuil défini, après quoi il est redirigé vers une autre interface.
    Weight : Le trafic est distribué selon un poids attribué à chaque interface.
    Volume (Bandwidth) : Le trafic est distribué pour répartir le volume en fonction du poids et de la bande passante disponible​.

3. Qu’est-ce qu’une zone SD-WAN ?

Une zone SD-WAN est un groupe logique d'interfaces membres au sein du SD-WAN. Cela permet d’appliquer des règles de pare-feu spécifiques à un groupe d’interfaces plutôt qu'à des interfaces individuelles. Cela donne un contrôle plus granulaire sur le trafic au sein du réseau​.

4. Rôle du Link Health Monitor :

Le Link Health Monitor (LHM) permet de surveiller la santé des connexions membres du SD-WAN. Il détecte l'état des liaisons en testant périodiquement la connectivité via des protocoles comme le ping, HTTP, TCP echo, ou TWAMP. Cela aide à éviter que du trafic soit envoyé sur une ligne dégradée ou hors service​.

5. Paramètres mesurés pour la qualité de ligne (Link Quality Measurement) :

    Latence (temps de réponse).
    Gigue (variabilité de la latence).
    Perte de paquets.
    Bande passante disponible​.

6. Notion de SLA Target :

Le SLA Target est un ensemble de critères de performance définis (comme la latence, la gigue et la perte de paquets) qu’une ligne doit respecter pour être utilisée dans le routage SD-WAN. Si un lien ne satisfait pas ces critères, il est retiré de la sélection dynamique​.

7. Traitement des règles SD-WAN par FortiGate :

Les règles SD-WAN sont traitées de manière séquentielle, de haut en bas, selon une logique similaire aux règles de pare-feu. La première règle correspondante est appliquée, et elles sont prioritaires par rapport aux routes de la table de routage. Cela permet un contrôle plus précis sur la manière dont le trafic est routé​.