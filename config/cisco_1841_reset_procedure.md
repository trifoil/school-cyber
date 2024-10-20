# How to reset

1) Power off 
2) Eject flash card
3) In rommon mode, enter ```confreg 0x2142```
4) Power off
5) Insert flashcard
6) Go to enable mode 
7) Type ```copy st run```
8) Restart by ```reload```

## no 6

```
! conf keys

        key chain OSPF-Link-4-6
            key 1
            cryptographic-algorithm hmac-sha-256 !not specified
            key-string s4e8fsevt4es9v4et4etet4ese4v68sve4r841se84848e
        exit

        key chain OSPF-Link-5-6
            key 1
            cryptographic-algorithm hmac-sha-256
            key-string 4518dxvt8f71vg843vt864qe368rt848d4rqt86qed4rtq
        end
```