### Services à utiliser / désactiver sur le FW

#### VLAN

1.  VLAN 30 (MANAGEMENT)

    - Administrative Access:
      - HTTPS
      - FMG-Access
      - FTM
      - HTTP
      - SSH
      - RADIUS ACCOUNTING
      - PING
      - SNMP
      - SECURITY FABRIC CONNECTION

2.  VLAN 10 (USER)

    - Administrative Access:
      - HTTPS
    - Bande passante limitée à 10 Mbps

3.  VLAN 50 (SEVER)
    - Administrative Access:
      - HTTPS
      - HTTP
      - PING
      - SNMP

---

### Policies & Règles de Pare-feu instaurées

#### VLAN

1. VLAN 30 (MANAGEMENT)
   - Service DENY ALL:
     - FTP
     - SSH
     - HTTP
     - HTTPS
     - DHCP
     - DNS
     - PING

---

### LOGS DU FIREWALL

- Logs autorisés uniquement sur les evenements de sécurités

- Log allowed traffic ; désactiver pour ne pas générer trop de logs 'inutiles'
- Log denied unicast traffic ; activé pour voir quel est le trafic qui a été bloqué
- Log denied broadcast traffic ; pas forcement necessaire
- Log local out traffic ; suivre le trafic sortant du fw

### Policies & Règles d'AntiVirus instaurés

- Methode : block dès qu'un virus est suspecté
- Protocols inspectés :
  - HTTP : activé pour protéger le trafic web
  - SMTP, POP3, IMAP, FTP, CIFS : ces protocoles ne sont pas utilisés donc cela ne sert à rien de les scanner.
