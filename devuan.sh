#!/data/data/com.termux/files/usr/bin/bash

# Devuan ARM64 Installer for Termux
pkg install root-repo x11-repo -y
pkg install proot tar wget xz-utils pulseaudio neofetch -y

echo ""
echo "[*] Setting up Devuan ARM64..."

folder=devuan-fs
tarball=devuan-rootfs.tar
url="https://github.com/codeplugs/Devuan/releases/download/v1.0/devuan-arm64-rootfs.tar.xz"

if [ -d "$folder" ]; then
    first=1
    echo "[*] Skipping download, rootfs already exists."
fi

if [ "$first" != 1 ]; then
    echo "[*] Downloading Devuan rootfs..."
    wget -q --show-progress "$url" -O "$tarball"
    mkdir -p "$folder"
    mkdir -p "$folder/binds"
    echo "[*] Extracting rootfs..."
    proot --link2symlink tar -xpf "$tarball" -C "$folder" --exclude='dev' || :
    rm "$tarball"
fi

# Basic networking config
echo "localhost" > $folder/etc/hostname
echo "127.0.0.1 localhost" > $folder/etc/hosts
echo "nameserver 8.8.8.8" > $folder/etc/resolv.conf

# Add PULSE_SERVER export to .bashrc
echo 'export PULSE_SERVER=127.0.0.1' >> $folder/root/.bashrc

bin=.devuan
linux=devuan

echo "[*] Creating launch script..."
cat > $bin <<- EOM
#!/data/data/com.termux/files/usr/bin/bash
cd \$(dirname \$0)

pulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1

unset LD_PRELOAD

command="proot"
command+=" --kill-on-exit"
command+=" --link2symlink"
command+=" -0"
command+=" -r $folder"

if [ -n "\$(ls -A $folder/binds 2>/dev/null)" ]; then
    for f in $folder/binds/* ; do
        . \$f
    done
fi

command+=" -b /dev"
command+=" -b /proc"
command+=" -b /sys"
command+=" -b /sdcard"
command+=" -b /mnt"
command+=" -b /data/data/com.termux/files/usr/tmp:/tmp"
command+=" -b $folder/root:/dev/shm"
command+=" -b /data/data/com.termux/files/usr/etc/resolv.conf:/etc/resolv.conf"

command+=" -w /root"

command+=" /usr/bin/env -i"
command+=" HOME=/root"
command+=" PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin"
command+=" TERM=\$TERM"
command+=" LANG=C.UTF-8"
command+=" /bin/bash --login"

com="\$@"
if [ -z "\$1" ]; then
    exec \$command -c \$'
# Install Git if not already installed
if ! command -v git >/dev/null 2>&1; then
    echo "[*] Git not found, installing from APT..."
    apt update && apt install git -y
fi

# Install Neofetch from GitHub if not already installed
if ! command -v neofetch >/dev/null 2>&1; then
    echo "[*] Neofetch not found, installing from GitHub..."
    git clone https://github.com/dylanaraps/neofetch.git /opt/neofetch
    ln -sf /opt/neofetch/neofetch /usr/local/bin/neofetch
    chmod +x /usr/local/bin/neofetch
fi

clear
echo "Welcome to Devuan!"
neofetch
exec /bin/bash --login'
else
    \$command -c "\$com"
fi
EOM

# Final setup
termux-fix-shebang $bin
chmod +x $bin
chmod -R 755 $folder

# Link command to global bin
echo 'bash .devuan' > $PREFIX/bin/$linux
chmod +x $PREFIX/bin/$linux

# First run
bash $bin

clear
echo ""
echo "[*] Devuan ARM64 installed."
echo "[*] You can run it anytime using: devuan"