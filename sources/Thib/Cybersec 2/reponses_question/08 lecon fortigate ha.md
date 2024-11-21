# Tache 2 : Synthese

1. Utilité de la haute disponibilité (HA) :

La haute disponibilité permet de garantir la continuité de service en cas de défaillance d’un composant. En synchronisant plusieurs appareils FortiGate, un des appareils prend le relais (basculement) si celui qui est actif tombe en panne. Cela permet de minimiser les interruptions de service dans un réseau d'entreprise .
2. Les deux modes de haute disponibilité :

    Mode actif-passif : Seul un FortiGate traite le trafic (actif) tandis que les autres sont passifs et prennent le relais en cas de panne.
    Mode actif-actif : Tous les FortiGate du cluster traitent le trafic et partagent la charge réseau .

3. Utilité du protocole FGCP (FortiGate Clustering Protocol) :

Le FGCP est utilisé pour la communication entre les membres du cluster HA. Il permet de :

    Découvrir les membres du même cluster HA.
    Élire le FortiGate primaire.
    Synchroniser les configurations et les données.
    Détecter les défaillances .

4. Conditions requises pour la mise en œuvre de la HA sur des FortiGate :

    Les FortiGate doivent avoir le même modèle et la même version de firmware.
    Ils doivent partager les mêmes licences.
    Une connexion heartbeat doit être établie entre eux via un lien dédié.
    Les interfaces réseau doivent être connectées aux mêmes domaines de diffusion .

5. Que se passe-t-il si les membres du cluster n’ont pas les mêmes licences ?

Si les membres n'ont pas les mêmes licences, le cluster s'aligne sur la licence la plus faible. Par exemple, si un des FortiGate n'a pas de licence antivirus, tout le cluster fonctionnera sans antivirus .
6. Processus d’élection du FortiGate primaire avec "HA override" activé :

Avec HA override activé, la priorité configurée des FortiGate est le critère principal pour déterminer le primaire, avant le temps de fonctionnement. Si deux appareils ont la même priorité, on regarde ensuite le temps de fonctionnement et le numéro de série .
7. Processus d’élection du FortiGate primaire avec "HA override" désactivé :

Lorsque HA override est désactivé, le FortiGate avec le plus grand nombre d’interfaces monitorées actives devient le primaire. Si deux appareils ont le même nombre d’interfaces up, le temps de fonctionnement (uptime) et le numéro de série sont pris en compte .
8. Trois caractéristiques des interfaces heartbeat :

    Utilisées pour détecter les pannes des autres membres du cluster.
    Connectées en UTP RJ45, elles nécessitent une bande passante suffisante.
    Elles doivent être isolées du reste du réseau pour éviter des interférences .

9. Interfaces d’un cluster HA à monitorer :

Il est recommandé de monitorer les interfaces réseau qui traitent du trafic critique. Seules les interfaces physiques, VLAN et LAG peuvent être monitorées. Il est déconseillé de surveiller les interfaces heartbeat .
10. Notion de synchronisation des sessions :

La synchronisation des sessions permet de maintenir les sessions actives sur un secondaire en cas de basculement. Cela assure une transition transparente lors du failover .
11. Cinq paramètres de configuration non synchronisés dans un cluster HA :

    La configuration des interfaces de gestion.
    Le paramètre HA override.
    La priorité HA.
    Les noms d’hôte.
    Les caches web ou email .

12. Trois causes menant à un basculement (failover) :

    Panne d’un membre du cluster (dead member).
    Défaillance d’un lien sur une interface surveillée (failed link).
    Surutilisation de la mémoire ou d'autres ressources .

13. Cinq méthodes de balancement de charge en mode actif-actif :

    Round-robin : Distribution des sessions à tour de rôle.
    Weight-round-robin : Distribution en fonction du poids des membres.
    Random : Distribution aléatoire des sessions.
    Iphub : Sessions avec le même couple IP source/destination envoyées au même membre.
    Ipport : Sessions distribuées selon les adresses et ports source/destination .