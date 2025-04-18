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
    - Création du schéma topologie de notre Agence 7 [Voir le schéma Topologie Agence 7](/Topologie_Agence_7.drawio.png) et [ Voir le schéma Topologie Globale](/Topologie%20Globale%20-%20WAN1%20-%20OSPF.drawio.png)
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
- **Switch** : Connexion au switch

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

  - Tâches :
    - SSH + banner + timeout

- **Firewall**

  - Tâches :
    - DMZ + WAN 2 + IP statiques DMZ & WAN 2 + banner + timeout

- **Switch**
  - Tâches :
    - SSH + banner + timeout

#### Problèmes rencontrés

- Problème SSH sur le switch étant donné mauvaise version IOS

#### Planification des tâches pour le cours suivant

- **Router** : Ajout de sécurité lié au ssh (TO, Logging events, retries)
- **Firewall** : règles fw (création de policies) + port sécurity + dhcp snooping
- **Switch** : Ajout de sécurité lié au ssh (TO, Logging events, retries)

---

### [7/10]

- **Router**

  - Tâches :
    - Vérification device (SSH, sécurité) + ajout des sécurités SSH

- **Firewall**

  - Tâches :
    - Création des règles du FW (policies), port security, dhcp snooping

- **Switch**
  - Tâches :
    - Vérification device (SSH, sécurité) + ajout des sécurités SSH

#### Problèmes rencontrés

- /

#### Planification des tâches pour le cours suivant

- - - **Effectuer les MAJ suite aux indications du professeur**
- - - **MAJ du kanban board sur teams pour avoir une meilleure vue d'ensemble des tâches à réaliser**

- **Router** : création script de la configuration de base
- **Firewall** : règles de pare feu (web filter)
- **Switch** : supression des interfaces des vlans1

---

### [9/10]

- **Router**

  - Tâches :
    - création script de la configuration de base
    - ajout d'une police de pwd

- **Firewall**

  - Tâches:
    - ajout d'une police de pwd

- **Switch**
  - Tâches :
    - création script de la configuration de base
    - Suppression des interfaces sur la VLAN 1
    - ajout d'une police de pwd

#### Problèmes rencontrés

- /

#### Planification des tâches pour le cours suivant

- **Router** : Suppression des services inutiles
- **Firewall** : Suppression des services inutiles sur les interfaces + rules fw + logs + portail captif
- **Switch** : Mise en place stp

---

### [14/10]

- **Router**

  - ## Tâches :
    - Port security : 2 MAC maximum
    - DHCP snooping : GigabitEthernet 1/0/24 fiable (les autres non)
    - Dynamic ARP Inspection (DAI) : inspection sur la vlan des utilisateurs, prévention des attaques par flooding

- **Firewall**

  - ## Tâches:
    - Désactivation des MAJ automatiques
    - Suppression des services inutiles sur les VLAN
    - Ajout des logs
    - Règles AntiVirus

- **Switch**
  - ## Tâches :

#### Problèmes rencontrés

- /

  #### Planification des tâches pour le cours suivant

  - **Router** : Désactiver les services inutiles + sécurité login + ajout service NTP + Mise en place script WAN1 (création et installation)
  - **Firewall** : Désactiver les services inutiles + sécurité login + ajout service NTP
  - **Switch** : Désactiver les services inutiles + sécurité login + ajout service NTP + STP

---

### [21/10]

- **Router (WAN1)**

  - ## Tâches:
    - Installation des scripts préparés à l'avance
    - CHangement dans le script, utilisation d'un mot de passe en `message-diges` en md5 plutôt qu'une clé chiffrée en sha-256

- **Firewall**

  - ## Tâches:
    - Désactivation des MAJ automatiques
    - Suppression des services inutiles sur les VLAN
    - Ajout des logs
    - Règles AntiVirus

- **Switch**
  - ## Tâches :

---

#### Problèmes rencontrés

- Cables moisis avec connecteurs cassés qui se déconnectent pour aucune raison apparente
