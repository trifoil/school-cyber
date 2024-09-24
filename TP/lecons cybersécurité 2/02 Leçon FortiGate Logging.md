Étude du chapitre

Durée : 2x20 minutes.

En vous aidant des notes de cours, réalisez :

    soit un résumé,
    soit des fiches (flash cards),
    soit un mind map,
    soit mémorisez les notions essentielles du chapitre via les techniques de mémorisation qui vous conviennent.

Votre travail doit vous permettre de répondre aux questions suivantes :

    Citez trois avantages d’utiliser la journalisation.
    Quel peut être l’inconvénient d’utiliser la journalisation.
    Où peut-on stocker les journaux générés par un FortiGate ?
    Citez les types de journaux disponibles sur un FortiGate. Quel genre d’informations chacun de ces types de journaux enregistre-t-il ?
    Citez dans l’ordre les niveaux de sévérité des journaux.
    Un FortiAnalyzer/FortiManager doit-il être dans le même réseau qu’un FortiGate pour que celui-ci puisse lui envoyer ses logs ?
    Dans le log ci-dessous, pouvez-vous déterminer :
        De quel type et sous-type de log il s’agit.
        La règle de pare-feu qui a autorisé ou refusé le trafic.
        Le niveau de sévérité.
        Si le paquet a été autorisé ou refusé.
        L’IP source qui a généré le trafic. 

date=2019-05-15 time=18:03:35 logid="1059028705" type="utm" subtype="app-ctrl" 
eventtype="app-ctrl-all" level="warning" vd="root" eventtime=1557968615 
appid=16072 srcip=10.1.100.22 dstip=195.8.215.136 srcport=50798 dstport=443 
srcintf="port10" srcintfrole="lan" dstintf="port9" dstintfrole="wan" 
proto=6 service="HTTPS" direction="incoming" policyid=3 sessionid=4414 
applist="block-social.media" appcat="Video/Audio" app="Dailymotion" 
action="block" hostname="www.dailymotion.com" incidentserialno=1962906682 
url="/" msg="Video/Audio: Dailymotion," apprisk="elevated"

## Reponses theoriques


Citez trois avantages d’utiliser la journalisation.

* Apporte de la visibilité sur les activités du réseau
* Facilite l’établissement d’une ligne de base du réseau.
* Important du point de vue de la sécurité
    *  Enregistrement de différents événements critiques (traçabilité)
    * Parfois la journalisation est obligatoire de par la loi

Quel peut être l’inconvénient d’utiliser la journalisation.

* Consomme des ressources

Où peut-on stocker les journaux générés par un FortiGate ?



Citez les types de journaux disponibles sur un FortiGate. Quel genre d’informations chacun de ces types de journaux enregistre-t-il ?

* Traffic Logs (Les journaux de trafic)
    * 
* 
    * 
* 
    * 

Citez dans l’ordre les niveaux de sévérité des journaux.
Un FortiAnalyzer/FortiManager doit-il être dans le même réseau qu’un FortiGate pour que celui-ci puisse lui envoyer ses logs ?
Dans le log ci-dessous, pouvez-vous déterminer :
    De quel type et sous-type de log il s’agit.
    La règle de pare-feu qui a autorisé ou refusé le trafic.
    Le niveau de sévérité.
    Si le paquet a été autorisé ou refusé.
    L’IP source qui a généré le trafic. 