zabbix_export:
  version: '7.0'
  host_groups:
    - uuid: f0f1211ae27c448c9ee3fd210e9d60d0
      name: Firewall
    - uuid: d023baef052948cc86e6888ee84890dd
      name: Router
    - uuid: 3ddb8437f4394258bf49e886e5c88391
      name: Switch
    - uuid: 21fcc4b057ca443d8cfe8ce7333f4ed9
      name: 'Windows server'
  hosts:
    - host: 'Fortigate - - - - AG_2_FW_1_PD_P'
      name: 'Fortigate - - - - AG_2_FW_1_PD_P'
      templates:
        - name: 'FortiGate by SNMP'
      groups:
        - name: Firewall
      interfaces:
        - type: SNMP
          ip: 172.19.50.254
          port: '161'
          details:
            community: IT
          interface_ref: if1
      inventory_mode: DISABLED
    - host: 'Router - - - - AG_2_RT_1_PD_P'
      name: 'Router - - - - AG_2_RT_1_PD_P'
      templates:
        - name: 'Cisco IOS by SNMP'
      groups:
        - name: Router
      interfaces:
        - type: SNMP
          ip: 172.19.200.1
          port: '161'
          details:
            community: IT
          interface_ref: if1
      inventory_mode: DISABLED
    - host: 'Server - - - - AG_2_SP_1_PD_P'
      name: 'Server - - - - AG_2_SP_1_PD_P'
      templates:
        - name: 'Windows by Zabbix agent'
      groups:
        - name: 'Windows server'
      interfaces:
        - ip: 172.19.50.1
          interface_ref: if1
      inventory_mode: DISABLED
    - host: 'Switch Cisco L2 - - - - AG_2_S2_1_PD_P'
      name: 'Switch Cisco L2 - - - - AG_2_S2_1_PD_P'
      templates:
        - name: 'Cisco IOS by SNMP'
      groups:
        - name: Switch
      interfaces:
        - type: SNMP
          ip: 172.19.30.200
          port: '161'
          details:
            community: IT
          interface_ref: if1
      inventory_mode: DISABLED
