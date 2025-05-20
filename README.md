<p align="center">My Channel</br><b> | <a href="https://m.facebook.com/codeplugs/">Facebook</a> |  <a href="https://m.youtube.com/@codeplug756">Youtube</a> |</b></p>

 --- 
## Devuan on Termux Android
 <img src="https://raw.githubusercontent.com/wahasa/Manjaro/refs/heads/main/Patch/Manjaro.jpg"> 

* Install Apps on Android
     <p>install termux from F-Droid. or google drive https://drive.google.com/file/d/163kv3zp2MTkKhYxEwZ0oxWXk19_O_gAl/view?usp=drivesdk </p>

### Installation

Copy and paste this commands to Termux
 <br/><p/>
Rootfs : Arm64 (Aarch64)
```
apt update ; apt install wget ; wget https://raw.githubusercontent.com/wahasa/Manjaro/refs/heads/main/Install/manjaro.sh ; chmod +x manjaro.sh ; ./manjaro.sh
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