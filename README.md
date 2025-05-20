<p align="center">My Channel</br><b> | <a href="https://m.facebook.com/codeplugs/">Facebook</a> |  <a href="https://m.youtube.com/@codeplug756">Youtube</a> |</b></p>

 --- 
## Devuan on Termux Android
 <img src="https://raw.githubusercontent.com/codeplugs/Devuan/refs/heads/main/Screenshot_2025-05-21-02-11-33-776_com.termux.jpg"> 

* Install Apps on Android
     <p>install termux from F-Droid. or google drive https://drive.google.com/file/d/163kv3zp2MTkKhYxEwZ0oxWXk19_O_gAl/view?usp=drivesdk </p>

### Installation

Copy and paste this commands to Termux
 <br/><p/>
Rootfs : Arm64 (Aarch64)
```
apt update ; apt install wget ; wget https://raw.githubusercontent.com/codeplugs/Devuan/refs/heads/main/devuan.sh ; chmod +x devuan.sh ; ./devuan.sh
```


---
* Login Devuan
```
devuan
```

* Logout Devuan
```
exit
```

* Remove Devuan
```
chmod -R 775 devuan-fs ; rm -rf devuan-fs .devuan $PREFIX/bin/devuan
```
---
Basic commands Devuan
> apt update : Update list package.</br>
> apt upgrade : Upgrade package.</br>
> apt search (pkg) : Search package.</br>
> apt install (pkg) : Install package.</br>
> apt autoremove (pkg) : Delete package.</br>
> apt -h : Help all commands.

---
## Desktop Environment

install desktop Xfce and vnc viewer
```
apt update  ; apt install tigervnc-standalone-server xfce4 xfce4-terminal dbus-x11 -y
```
<img src="https://raw.githubusercontent.com/codeplugs/Devuan/refs/heads/main/Screenshot_2025-05-21-02-11-33-776_com.termux.jpg"> 
