### Journal de bord du projet Cyber Sécurité 1

#### Informations générales
- **Nom du projet** : Gestion et sécurisation d'une agence Cyber Sécurité
- **Date de début** : 24/09
- **Responsable** : Bruneau Mattias, VanGeebergen Augustin [Agence 7](https://hehbe.sharepoint.com/:x:/s/ProjetNCS24-25/EdweGC-EY5BFsuIHzsa7iVgBw1Zvj9vY04dX3xhwbmGvQQ?e=5gkhVu)
- **Équipements utilisés** : Cisco Router, Cisco Pare-feu, Cisco Switch [Voir le fichier du listing matériel](https://hehbe.sharepoint.com/:x:/s/ProjetNCS24-25/ETGzcyEQXQxNslHoVWp1CxQBCQ8W4vsedDhDQMpND4AyOg?e=YgYeFm)
- **Objectif** : Créer et sécuriser une infrastructure réseau

---

### Tâches journalières

#### [24/09]
- **Documentation**
  - Tâches : 
    - Calcul d'ip + vlans [Voir le plan d'adressage IP](https://hehbe.sharepoint.com/:x:/s/ProjetNCS24-25/EcETquFhT_xKs3_gccl2YeoBYWN3p69SK__KNRE3zvjxvA?e=kebmIb)
    - Création du schéma topologie de notre Agence 7 [Voir le schéma Topologie Agence 7](/Topologie_Agence_7.drawio.png) et  [ Voir le schéma Topologie Globale](/Topologie%20Globale%20-%20WAN1%20-%20OSPF.drawio.png)
    - Etablissement d'un plan de nommage pour le matériel [Voir le plan de nommage](https://hehbe.sharepoint.com/:b:/s/ProjetNCS24-25/Eeo_XCfsLiNDtg6XA8V0OrABeK48h_H_cILAkcAcdGktkg?e=8AbVON)
    - Listing du matériel (modèle fw, switch, router) [Voir le fichier du listing matériel](https://hehbe.sharepoint.com/:x:/s/ProjetNCS24-25/ETGzcyEQXQxNslHoVWp1CxQBCQ8W4vsedDhDQMpND4AyOg?e=YgYeFm)

- **Router**
  - Tâches :
    - Installation du router sur le rack informatique

- **Firewall**
  - Tâches :
    - Installation du Firewall sur le rack informatique

- **Switch**
  - Tâches :
    - Installation du Switch sur le rack informatique


#### Problèmes rencontrés
- Reinitialisation de la configuration précédente

#### Planification des tâches pour le cours suivant
- **Router** : Connexion au router
- **Firewall** : Connexion au FW
- **Switch** :  Connexion au switch

---


#### [25/09]
- **Router**
  - Tâches :
    - Première connexion au router
    - Création admin + pwd

- **Firewall**
  - Tâches :
    - Première connexion au FW
    - Création admin + pwd

- **Switch**
  - Tâches :
    - Première connexion au switch
    - Création admin + pwd


#### Problèmes rencontrés
- Problème d'affichage dans le terminal.

#### Planification des tâches pour le cours suivant
- **Router** : Gestion des interfaces. (IP Statiques WAN1, FW)
- **Firewall** : Création des interfaces pour les VLANs (sous-interfaces avec assignations des ranges IP en DHCP)
- **Switch** : Gestion des VLANs + assignations des ports 

---

#### [02/10]
- **Router**
  - Tâches :
    - Gestion des interfaces (IP Statiques WAN1, FW)
    - Assignation WEB ui 

- **Firewall**
  - Tâches :
    - Création des interfaces pour les VLANs (sous-interfaces avec assignations des ranges IP en DHCP)

- **Switch**
  - Tâches :
    - Gestion des VLANs + assignations des ports 


#### Problèmes rencontrés
- Pas de problèmes majeurs rencontrés. (Temps de réponse FW)

#### Planification des tâches pour le cours suivant
- **Router** : Gestion SSH + Banner motd + Timeout après 3 essais et après 5 min d'inactivité 
- **Firewall** : Création interface DMZ + Création interface WAN2 + assignation des adresses IP statiques + Banner motd + Timeout après 3 essais et après 5 min d'inactivité 
- **Switch** : Banner motd + SSH + Timeout après 3 essais et après 5 min d'inactivité 

---

#### [03/10]
- **Router**
  - Tâches : SSH + banner + timeout 
    - 

- **Firewall**
  - Tâches : DMZ + WAN 2 + IP statiques DMZ & WAN 2 + banner + timeout
    - 

- **Switch**
  - Tâches : SSH + banner + timeout
    - 


#### Problèmes rencontrés
- Problème SSH sur le switch étant donné mauvaise version IOS 

#### Planification des tâches pour le cours suivant
- **Router** : /
- **Firewall** : règles fw
- **Switch** : /

---