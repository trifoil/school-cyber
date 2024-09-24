# School-cyber

0 heures de sommeil pour nous

## Config de minicom

Pour voir le point de montage de la console série (normalement /dev/ttyUSB0) :

```
udo dnf install minicom
```

Pour lancer :
```
sudo minicom -D /dev/ttyUSB0 -b 9600

```

## Config de screen

```
sudo dnf install screen
```

Pour lancer :

```
sudo screen /dev/ttyUSB0 9600
```