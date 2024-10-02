# Tache 2 : Synthese

1. **Trois avantages de superviser un réseau :**  
   - Disposer de données sur le fonctionnement du réseau (id. goulots d'étranglementp, parties les plus utilisées, BP) .
   - Création d'une base de référence réseau pour surveiller la croissance du trafic et l'évolution du comportement du réseau .
   - Être alerté rapidement en cas de problème, facilitant ainsi le dépannage .

2. **Différence entre "poll" et "trap" :**  
   - **Polling (sondage)** : Méthode active où la station de gestion interroge périodiquement les équipements pour obtenir des informations. Cette méthode consomme des ressources, même s'il n'y a pas d'informations utiles à récupérer .  
   - **Trap (déroutement)** : Méthode passive où l'équipement prend l'initiative de notifier directement la station de gestion lorsqu'un événement particulier survient, basé sur des seuils prédéfinis .

3. **Trois inconvénients liés au fait de superviser trop d’éléments :**  
   - Surveiller trop d'éléments consomme des ressources sur les périphériques .  
   - Utilisation excessive de la bande passante .  
   - Risque de polluer la visibilité des incidents importants .

4. **Cinq paramètres qu'il peut être intéressant de monitorer :**  
   - Le pourcentage de bande passante utilisée .  
   - Le pourcentage de paquets en erreur .  
   - La température des équipements .  
   - L'utilisation du processeur (CPU) .  
   - L'état des services (up/down) .

5. **Cinq questions à se poser concernant la mise en place d’une gestion des alarmes :**  
   - Quand faut-il générer une alarme ?   
   - Limiter le nombre d'alertes pour éviter la surcharge d'information ?   
   - Le niveau d'importance de l'alarme est-il clairement visible ?   
   - Qui doit être alerté en cas de problème ?   
   - Quel type d'alerte doit être utilisé (email, SMS, console de monitoring) ? 

6. **Peut-on automatiser une action en réaction à une alarme ? Citez deux exemples :**  
   Oui, il est possible d'automatiser des actions.  
   - Exemple 1 : Si le service HTTP est arrêté, un script peut redémarrer automatiquement le service .  
   - Exemple 2 : Si un serveur est surchargé, il est possible de désactiver certains services temporaires .

7. **Objectif du filtrage des alarmes :**  
   L'objectif principal est d'éviter une cascade d'alarmes inutiles, de se concentrer sur l'incident critique et de simplifier la gestion des alertes .

# Tache 4 : Solutions logicielles

1. **Choisissez deux solutions de monitoring qui disposent d’une version gratuite :**
    - Zabbix .
    - PRTG Network Monitor .

2. **Comparez ces deux solutions de monitoring afin d’en choisir une à mettre en œuvre dans le cadre du projet.**
    - Zabbix
        - **Coût:** Zabbix is completely open-source, meaning it is free to use with no sensor limitations .
        - **Features:** SNMP, ICMP, HTTP/HTTPS, SSH, Telnet, Agent-based, JMX, ODBC, IPMI, mais pas de flow protocols nativement ! 
        - **Scalabilité:** Tres flexible, (medium - grandes enterprises, supporte des milliers d'appareils en même temps) .
        - **Customisation:** Extrêmement customisable .
        - **Complexité:** Compliqué à installer pour les nouveaux utilisateurs, sa flexibilité peut ralentir son déploiement et sa configuration. Il possède cependant une excellente communauté .
        - **Cas d'usage:** Excellent quand on a besoin de données en profondeur. Pour les utilisateurs à l'aise .

    - PRTG Network Monitor
        - **Coût:** Gratuit jusque 100 relevés de mesure. Suffisant pour des petits réseaux . 
        - **Features:** SNMP, WMI, NetFlow/sFlow/jFlow, SSH/HTTP/HTTPS, Ping, Packet Sniffing . 
        - **Scalabilité:** Plus de coûts pour les grosses infrastructures, peut demander plus de planification .
        - **Customisation:** Customisation de dashboards, carte réseau visuelle .
        - **Complexité:** Interface user-friendly, setup rapide, plus facile à installer et configurer. auto-discovery .
        - **Cas d'usage:** Excelleent quand petite infra, besoin de déploiement rapide. Pour les utilisateurs novices .

    Solution choisie
    
    - Nous choisirons donc PRTG pour sa facilité et sa rapidité d'installation