## Consignes

En vous aidant des notes de cours, réalisez :

    soit un résumé,
    soit des fiches (flash cards),
    soit un mind map,
    soit mémorisez les notions essentielles du chapitre via les techniques de mémorisation qui vous conviennent.

Votre travail doit vous permettre de répondre aux questions suivantes :

    Citez les méthodes d’authentification des utilisateurs disponibles sur le FortiGate.
    Quelles méthodes peut-on utiliser comme 2ème facteur pour l’authentification ?
    Expliquez les notions d’authentification active et passive. Que se passe-t-il si les deux méthodes sont activées ?
    Citez les quatre types de groupes d’utilisateurs.
    Pourquoi faut-il parfois ajouter les services http et DNS dans les règles de pare-feu utilisant.
    Expliquez ce qu’est un portail captif.
    Pourquoi doit-on parfois exempter certains périphériques de l’authentification par portail captif ?
    Citez trois méthodes permettant de garantir l’authentification actives des utilisateurs.

Préparez l’implémentation de l’authentification que vous mettrez en œuvre sur le FortiGate de votre site/agence lors des séances de travaux pratiques.

Durée : 40 minutes.

Déterminez quel(s) accès vous souhaitez protéger avec une authentification.

Listez les paramètres de configuration dont vous aurez besoin pour la configuration de l’authentification.

    Où seront stocké les identifiants ?
    Utiliserez-vous l’authentification à deux facteur ?
    Allez-vous utiliser un portail captif ?
    … 

Préparez votre script ou complétez la liste des paramètres en indiquant la valeur qui devra être configurée pour chacun d'eux.

    Combien de temps un utilisateur peut-il rester inactif avant de devoir s'authentifier à nouveau ?
    Quelle est l’adresse IP du serveur d’authentification ?
    Quelles conditions d’utilisation (Disclaimer) les utilisateurs devront-ils accepter pour poursuivre l’accès ?
    …

Comment allez-vous tester votre configuration ?

Estimez le temps nécessaire à la mise en œuvre sur site.

Planifiez votre intervention (à quel date/heure prévoyez-vous cette intervention ? D’autres configurations doivent-elles encore être réalisées avant celle-ci ?, …). Le cas échéant, réorganisez les autres tâches.

Dans votre planification, avez-vous pris en compte les points de votre checklist méthodologique ?

## Reponses

### Méthodes d’authentification des utilisateurs sur FortiGate

* Par le pare-feu
* Par mdp local
* Par authentification par serveur
    * Créer un compte utilisateur de type « Remote » et spécifier le serveur qui contiendra/vérifiera les identifiants
    * Ajouter un serveur d'authentification à un groupe d'utilisateurs et ajouter le groupe d'utilisateur à une règle de pare-feu
* Auth à deux facteurs
* FortiToken assigné à un ustilisateur
* Authentification active
* Authentification passive


### Méthodes comme 2ème facteur pour l’authentification ?

* OTP = ```One Time Password```
* 

### Expliquez les notions d’authentification active et passive. Que se passe-t-il si les deux méthodes sont activées ?

* si auth active + passive :    
l'authentification ```active = backup``` (si d'échec de l'authentification passive)
### Citez les quatre types de groupes d’utilisateurs.

* ```Firewall``` user group     
localement au niveau d'une règle de pare-feu afin d'autoriser des accès uniquement à certains groupes d'utilisateurs        
User & Device > User Groups > Create New
* ```Guest``` user group       
accès invités réseaux sans fil.         
ce type de compte contient le compte entier.        
expirent après une période prédéterminée
* ```Fortinet Single Sign-On``` (FSSO) user group   
pour l'authentification unique et passive
* ```RADIUS Single Sign-On``` (RSSO) user group     
pour l'authentification unique et passive

### Pourquoi faut-il parfois ajouter les services http et DNS dans les règles de pare-feu utilisant.

* http requis pour afficher la boite de dialogue de l'auth active
* résolution du nom d'hôte est souvent requise par le protocole de couche application, utilisé pour l'authentification (pas besoin d'auth)

### Expliquez ce qu’est un portail captif.

### Pourquoi doit-on parfois exempter certains périphériques de l’authentification par portail captif ?

### Citez trois méthodes permettant de garantir l’authentification actives des utilisateurs.

* Activer l'authentification dans chaque règle de pare-feu qui pourrait correspondre au trafic.
* Appliquer l'option d'authentification à la demande (CLI uniquement).      
    ```
    # config user setting
    (setting) # set auth-on-demand <always|implicit>
    ```
    * Implicit (défaut)         
    ne déclenchera pas l'authentification de l’utilisateur si autre règle sans authentification qui autorise le trafic.
    * Always        
    toujours auth pour les règles avec auth active activée.
* Activer un portail captif sur l'interface d'entrée du trafic.