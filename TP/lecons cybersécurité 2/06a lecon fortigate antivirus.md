# Tache 2 : Synthese

1. **Pourquoi utiliser un antivirus sur un Firewall (FW)?**

    L'antivirus sur un pare-feu (FW) permet de détecter et bloquer les malwares en temps réel avant qu'ils n'entrent dans le réseau. Cela protège le réseau en empêchant la propagation des menaces et en évitant que des malwares soient distribués depuis l'IP publique de l'entreprise. Il est particulièrement utile lorsque l'on ne peut pas contrôler l'antivirus de tous les périphériques connectés au réseau, comme les imprimantes ou les appareils BYOD (Bring Your Own Device) .

2. **Analyse heuristique, par signature et par sandbox :**

    - **Analyse par signature :** Identifie les virus en comparant les fichiers à une base de données de signatures connues. Cette méthode est rapide et efficace pour les malwares connus, mais elle ne peut pas détecter les menaces nouvelles ou obfusquées .
    - **Analyse heuristique :** Cherche des comportements suspects qui peuvent indiquer la présence d'un virus, même sans signature. Cela permet de détecter des menaces zero-day, mais il existe un risque accru de faux positifs .
    - **Analyse par sandbox :** Exécute les fichiers suspects dans un environnement virtuel sécurisé pour observer leur comportement en temps réel. Cela permet d'identifier des malwares inconnus, mais cette méthode est plus lente et peut être contournée par des techniques d'évasion .

3. **Limites de l'analyse par signature :**

    - Ne peut détecter que les malwares connus (nécessite une signature).
    - **Obsolescence rapide** des signatures face aux nouveaux malwares qui apparaissent quotidiennement.
    - **Vulnérabilité aux techniques d'obfuscation** telles que la compression, le chiffrement, ou le polymorphisme .

4. **Techniques d'obfuscation de malwares :**

    - **Compression :** Le fichier est compressé pour masquer sa signature.
    - **Polymorphisme :** Le code du malware change à chaque infection pour éviter la détection.
    - **Chiffrement :** Le malware est chiffré pour dissimuler son contenu .

5. **Techniques d'évasion d'une sandbox :**

    - **Interaction humaine :** Le malware attend une action humaine (comme un clic) pour s'exécuter.
    - **Détection de sandbox :** Le malware détecte qu'il est dans une sandbox et reste inactif.
    - **Fragmentation des données :** Le malware envoie ses paquets de données malveillantes de manière fragmentée pour contourner l'analyse .

6. **Caractéristiques du mode Full scan flow-based de l'antivirus FortiGate :**

    - Les paquets sont scannés en temps réel, avec une copie conservée en mémoire tampon.
    - Ce mode est rapide et nécessite moins de latence que le mode proxy-based.
    - Cependant, il consomme plus de CPU et n’offre pas autant de fonctionnalités de sécurité (comme l'inspection du SSH ou du MAPI) .

7. **Caractéristiques du mode Proxy-based full scan de l'antivirus FortiGate :**

    - Les fichiers sont entièrement bufferisés avant d’être scannés.
    - Aucun fichier n'est transmis à l'utilisateur avant la fin du scan, ce qui peut entraîner une **latence perceptible**.
    - Ce mode offre plus de fonctions de sécurité, mais il peut entraîner des délais, notamment pour les fichiers de grande taille ou les connexions lentes .