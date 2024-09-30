# Tache 2 : Synthese

1. **Types de menaces contre lesquelles un IPS protège** :

Un Intrusion Prevention System (IPS) protège contre divers types de menaces :

    Attaques connues basées sur des signatures (comme des virus ou exploits).
    Anomalies dans le trafic réseau, telles que les DoS (Denial of Service) et DDoS.
    Exploits visant à exploiter des vulnérabilités réseau et protocolaires (comme les paquets mal formés)​.

2. **Inconvénients de l’utilisation d’un IPS** :

    Faux positifs : Le trafic légitime peut être bloqué à tort, ce qui crée des interruptions.
    Impacts sur les performances : Un IPS mal configuré peut introduire de la latence, voire paralyser le réseau en cas de surcharge.
    Complexité de gestion : Le maintien et la gestion des signatures et des alertes IPS nécessitent des compétences avancées​.

3. **Sigles et leur signification** :

    IPS (Intrusion Prevention System) : Détecte et empêche les intrusions en bloquant le trafic malveillant.
    HIPS (Host-based Intrusion Prevention System) : Protège un hôte spécifique contre les intrusions.
    NIPS (Network-based Intrusion Prevention System) : Protège un réseau en surveillant le trafic réseau.
    IDS (Intrusion Detection System) : Détecte les intrusions sans bloquer le trafic, contrairement à l'IPS​.

4. **Quatre types de détection d’anomalies supportés par FortiGate** :

    Détection des floods : Détecte un volume anormalement élevé de trafic.
    Sweep/Scan : Détecte des tentatives de balayage de ports ou de scan de réseau.
    Source Anomaly : Détecte un volume élevé de trafic provenant d’une seule source IP.
    Destination Anomaly : Détecte un volume anormal de trafic destiné à une seule destination IP​.

5. **Web Application Firewall (WAF)** :

Un WAF est un dispositif de sécurité conçu pour protéger des applications web en filtrant et en surveillant le trafic HTTP/HTTPS. Il protège contre les attaques courantes visant les applications web, telles que :

    Cross-Site Scripting (XSS),
    SQL Injection,
    Exploits de vulnérabilités web​.