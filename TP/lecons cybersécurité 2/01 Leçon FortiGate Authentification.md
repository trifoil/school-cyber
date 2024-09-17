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

### Pourquoi faut-il parfois ajouter les services http et DNS dans les règles de pare-feu utilisant.

### Expliquez ce qu’est un portail captif.

### Pourquoi doit-on parfois exempter certains périphériques de l’authentification par portail captif ?

### Citez trois méthodes permettant de garantir l’authentification actives des utilisateurs.
