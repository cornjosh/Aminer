#!/usr/bin/env bash
#=============================================================
# https://github.com/cornjosh/Aminer
# A script that help you install miner software XMRIG on Android device
# Version: 1.0
# Author: cornjosh
# Blog: https://linkyou.top
#=============================================================

USER="12345"
PASS=''
MIMING_URL="mine.c3pool.com:13333"

VERSION=1.0
TOS=''
UBUNTU_VERSION=20.04.1
DONATE=1
RED_FONT_PREFIX="\033[31m"
LIGHT_GREEN_FONT_PREFIX="\033[1;32m"
LIGHT_BLUE_FONT_PREFIX="\033[1;34m"
FONT_COLOR_SUFFIX="\033[0m"


INFO(){
  echo -e "[${LIGHT_GREEN_FONT_PREFIX}INFO${FONT_COLOR_SUFFIX}] $1"
}
ERROR(){
  echo -e "[${RED_FONT_PREFIX}ERROR${FONT_COLOR_SUFFIX}] $1"
}
HEAD(){
  echo -e "${LIGHT_BLUE_FONT_PREFIX}##### $1 #####${FONT_COLOR_SUFFIX}"
}


HELLO(){
  HEAD "Aminer"
  echo "Aminer is a script that help you install miner software XMRIG on Android device. @v$VERSION
You can find the source code from https://github.com/cornjosh/Aminer
"
[ "$TOS" == '' ] && read -e -p "You are already understand the risks of the script.(Y/n)" TOS
[ "$TOS" == 'n' ] || [ "$TOS" == 'N' ] && ERROR "Canceled by user" && exit 0
}
USAGE(){
  echo "Aminer - A script that help you install miner software XMRIG on Android device @v$VERSION

Usage:
  bash <(curl -fsSL git.io/aminer) [options...] <arg>
Options:
  -y  Auto mode, ignore risks warning
  -u  Pool's user, the arguments like [username]
  -p  Pool's password, the arguments like [password]
  -o  Pool's url, the arguments like [mine.pool.example:1234]
  -d  Donate level to XMRIG's developers (not me),the arguments like [1]
  -g  Setup sshd with Github name, the arguments like [cornjosh]"

#  -o	Overwrite mode, this option is valid at the top
#  -g	Get the public key from GitHub, the arguments is the GitHub ID
#  -u	Get the public key from the URL, the arguments is the URL
#  -f	Get the public key from the local file, the arguments is the local file path
#  -p	Change SSH port, the arguments is port number
#  -d	Disable password login
}

GET_PASS(){
  [ "$PASS" == '' ] && PASS="Aminer-$(getprop ro.product.vendor.model|sed s/[[:space:]]//g)"
}


UBUNTU(){
  INFO "Upgrading packages" && pkg update && pkg upgrade -y
  INFO "Installing dependency" && pkg install wget proot -y
  cd "$HOME" || exit
  mkdir ubuntu-in-termux && INFO "Create $HOME/ubuntu-in-termux"
  UBUNTU_DOWNLOAD
  UBUNTU_INSTALL
  INFO "Ubuntu setup complete"
}

UBUNTU_DOWNLOAD(){
  HEAD "Download Ubuntu"
  cd "$HOME/ubuntu-in-termux" || exit
  [ -f "ubuntu.tar.gz" ] && rm -rf ubuntu.tar.gz && INFO "Remove old ubuntu image"
  local ARCHITECTURE=$(dpkg --print-architecture)
  case "$ARCHITECTURE" in
  aarch64)
    ARCHITECTURE=arm64
    ;;
  arm)
    ARCHITECTURE=armhf
    ;;
  amd64|x86_64)
    ARCHITECTURE=amd64
    ;;
  *)
    ERROR "Unsupported architecture :- $ARCHITECTURE" && exit 1
    ;;
  esac
  INFO "Device architecture :- $ARCHITECTURE"
  INFO "Downloading Ubuntu image"
  wget https://mirrors.ustc.edu.cn/ubuntu-cdimage/ubuntu-base/releases/${UBUNTU_VERSION}/release/ubuntu-base-${UBUNTU_VERSION}-base-${ARCHITECTURE}.tar.gz -O ubuntu.tar.gz
}

UBUNTU_INSTALL(){
  HEAD "Install Ubuntu"
  local directory=ubuntu-fs
  cd "$HOME/ubuntu-in-termux" || exit
  local cur=$(pwd)
  mkdir -p $directory && INFO "Create $HOME/ubuntu-in-termux/$directory"
  cd $directory || exit
  INFO "Decompressing the ubuntu rootfs" && tar -zxf "$cur/ubuntu.tar.gz" --exclude='dev' && INFO "The ubuntu rootfs have been successfully decompressed"
  printf "nameserver 8.8.8.8\nnameserver 8.8.4.4\n" > etc/resolv.conf && INFO "Fixing the resolv.conf"
  stubs=()
  stubs+=('usr/bin/groups')
  for f in "${stubs[@]}";do
  INFO "Writing stubs"
  echo -e "#!/bin/sh\nexit" > "$f"
  done
  INFO "Successfully wrote stubs"
  cd "$cur" || exit
  mkdir -p ubuntu-binds
  local bin=startubuntu.sh
  INFO "Creating the start script"
  cat > $bin <<- EOM
#!/bin/bash
cd \$(dirname \$0)
## unset LD_PRELOAD in case termux-exec is installed
unset LD_PRELOAD
command="proot"
## uncomment following line if you are having FATAL: kernel too old message.
#command+=" -k 4.14.81"
command+=" --link2symlink"
command+=" -0"
command+=" -r $directory"
if [ -n "\$(ls -A ubuntu-binds)" ]; then
    for f in ubuntu-binds/* ;do
      . \$f
    done
fi
command+=" -b /dev"
command+=" -b /proc"
command+=" -b /sys"
command+=" -b ubuntu-fs/tmp:/dev/shm"
command+=" -b /data/data/com.termux"
command+=" -b /:/host-rootfs"
command+=" -b /sdcard"
command+=" -b /storage"
command+=" -b /mnt"
command+=" -w /root"
command+=" /usr/bin/env -i"
command+=" HOME=/root"
command+=" PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/games:/usr/local/games"
command+=" TERM=\$TERM"
command+=" LANG=C.UTF-8"
command+=" /bin/bash --login"
com="\$@"
if [ -z "\$1" ];then
    exec \$command
else
    \$command -c "\$com"
fi
EOM
  termux-fix-shebang $bin
  chmod +x $bin
  rm ubuntu.tar.gz -rf && INFO "Delete Ubuntu image"
  INFO "Ubuntu $UBUNTU_VERSION install complete"
}

#install_ubuntu(){
#  pkg update && pkg upgrade -y
#  pkg install wget proot -y
#  cd "$HOME" || exit
#  mkdir ubuntu-in-termux
#  cd ubuntu-in-termux || exit
#  install1
#  cd "$HOME" || exit
#}
#
#install1 () {
#time1="$( date +"%r" )"
#directory=ubuntu-fs
#UBUNTU_VERSION=20.04.1
#if [ -d "$directory" ];then
#first=1
#printf "\x1b[38;5;214m[${time1}]\e[0m \x1b[38;5;227m[WARNING]:\e[0m \x1b[38;5;87m Skipping the download and the extraction\n"
#elif [ -z "$(command -v proot)" ];then
#printf "\x1b[38;5;214m[${time1}]\e[0m \x1b[38;5;203m[ERROR]:\e[0m \x1b[38;5;87m Please install proot.\n"
#printf "\e[0m"
#exit 1
#elif [ -z "$(command -v wget)" ];then
#printf "\x1b[38;5;214m[${time1}]\e[0m \x1b[38;5;203m[ERROR]:\e[0m \x1b[38;5;87m Please install wget.\n"
#printf "\e[0m"
#exit 1
#fi
#if [ "$first" != 1 ];then
#if [ -f "ubuntu.tar.gz" ];then
#rm -rf ubuntu.tar.gz
#fi
#if [ ! -f "ubuntu.tar.gz" ];then
#printf "\x1b[38;5;214m[${time1}]\e[0m \x1b[38;5;83m[Installer thread/INFO]:\e[0m \x1b[38;5;87m Downloading the ubuntu rootfs, please wait...\n"
#ARCHITECTURE=$(dpkg --print-architecture)
#case "$ARCHITECTURE" in
#aarch64) ARCHITECTURE=arm64;;
#arm) ARCHITECTURE=armhf;;
#amd64|x86_64) ARCHITECTURE=amd64;;
#*)
#printf "\x1b[38;5;214m[${time1}]\e[0m \x1b[38;5;203m[ERROR]:\e[0m \x1b[38;5;87m Unknown architecture :- $ARCHITECTURE"
#exit 1
#;;
#
#esac
#
#wget https://mirrors.ustc.edu.cn/ubuntu-cdimage/ubuntu-base/releases/${UBUNTU_VERSION}/release/ubuntu-base-${UBUNTU_VERSION}-base-${ARCHITECTURE}.tar.gz -O ubuntu.tar.gz
#printf "\x1b[38;5;214m[${time1}]\e[0m \x1b[38;5;83m[Installer thread/INFO]:\e[0m \x1b[38;5;87m Download complete!\n"
#
#fi
#
#cur=`pwd`
#mkdir -p $directory
#cd $directory
#printf "\x1b[38;5;214m[${time1}]\e[0m \x1b[38;5;83m[Installer thread/INFO]:\e[0m \x1b[38;5;87m Decompressing the ubuntu rootfs, please wait...\n"
#tar -zxf $cur/ubuntu.tar.gz --exclude='dev'||:
#printf "\x1b[38;5;214m[${time1}]\e[0m \x1b[38;5;83m[Installer thread/INFO]:\e[0m \x1b[38;5;87m The ubuntu rootfs have been successfully decompressed!\n"
#printf "\x1b[38;5;214m[${time1}]\e[0m \x1b[38;5;83m[Installer thread/INFO]:\e[0m \x1b[38;5;87m Fixing the resolv.conf, so that you have access to the internet\n"
#printf "nameserver 8.8.8.8\nnameserver 8.8.4.4\n" > etc/resolv.conf
#stubs=()
#stubs+=('usr/bin/groups')
#for f in ${stubs[@]};do
#printf "\x1b[38;5;214m[${time1}]\e[0m \x1b[38;5;83m[Installer thread/INFO]:\e[0m \x1b[38;5;87m Writing stubs, please wait...\n"
#echo -e "#!/bin/sh\nexit" > "$f"
#done
#printf "\x1b[38;5;214m[${time1}]\e[0m \x1b[38;5;83m[Installer thread/INFO]:\e[0m \x1b[38;5;87m Successfully wrote stubs!\n"
#cd $cur
#
#fi
#
#mkdir -p ubuntu-binds
#bin=startubuntu.sh
#printf "\x1b[38;5;214m[${time1}]\e[0m \x1b[38;5;83m[Installer thread/INFO]:\e[0m \x1b[38;5;87m Creating the start script, please wait...\n"
#cat > $bin <<- EOM
##!/bin/bash
#cd \$(dirname \$0)
### unset LD_PRELOAD in case termux-exec is installed
#unset LD_PRELOAD
#command="proot"
### uncomment following line if you are having FATAL: kernel too old message.
##command+=" -k 4.14.81"
#command+=" --link2symlink"
#command+=" -0"
#command+=" -r $directory"
#if [ -n "\$(ls -A ubuntu-binds)" ]; then
#    for f in ubuntu-binds/* ;do
#      . \$f
#    done
#fi
#command+=" -b /dev"
#command+=" -b /proc"
#command+=" -b /sys"
#command+=" -b ubuntu-fs/tmp:/dev/shm"
#command+=" -b /data/data/com.termux"
#command+=" -b /:/host-rootfs"
#command+=" -b /sdcard"
#command+=" -b /storage"
#command+=" -b /mnt"
#command+=" -w /root"
#command+=" /usr/bin/env -i"
#command+=" HOME=/root"
#command+=" PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/games:/usr/local/games"
#command+=" TERM=\$TERM"
#command+=" LANG=C.UTF-8"
#command+=" /bin/bash --login"
#com="\$@"
#if [ -z "\$1" ];then
#    exec \$command
#else
#    \$command -c "\$com"
#fi
#EOM
#printf "\x1b[38;5;214m[${time1}]\e[0m \x1b[38;5;83m[Installer thread/INFO]:\e[0m \x1b[38;5;87m The start script has been successfully created!\n"
#printf "\x1b[38;5;214m[${time1}]\e[0m \x1b[38;5;83m[Installer thread/INFO]:\e[0m \x1b[38;5;87m Fixing shebang of startubuntu.sh, please wait...\n"
#termux-fix-shebang $bin
#printf "\x1b[38;5;214m[${time1}]\e[0m \x1b[38;5;83m[Installer thread/INFO]:\e[0m \x1b[38;5;87m Successfully fixed shebang of startubuntu.sh! \n"
#printf "\x1b[38;5;214m[${time1}]\e[0m \x1b[38;5;83m[Installer thread/INFO]:\e[0m \x1b[38;5;87m Making startubuntu.sh executable please wait...\n"
#chmod +x $bin
#printf "\x1b[38;5;214m[${time1}]\e[0m \x1b[38;5;83m[Installer thread/INFO]:\e[0m \x1b[38;5;87m Successfully made startubuntu.sh executable\n"
#printf "\x1b[38;5;214m[${time1}]\e[0m \x1b[38;5;83m[Installer thread/INFO]:\e[0m \x1b[38;5;87m Cleaning up please wait...\n"
#rm ubuntu.tar.gz -rf
#printf "\x1b[38;5;214m[${time1}]\e[0m \x1b[38;5;83m[Installer thread/INFO]:\e[0m \x1b[38;5;87m Successfully cleaned up!\n"
#printf "\x1b[38;5;214m[${time1}]\e[0m \x1b[38;5;83m[Installer thread/INFO]:\e[0m \x1b[38;5;87m The installation has been completed! You can now launch Ubuntu with ./startubuntu.sh\n"
#printf "\e[0m"
#
#}

UBUNTU_START(){
  INFO "Start up Ubuntu..." && bash "$HOME/ubuntu-in-termux/startubuntu.sh"
}

TERMUX_BASHRC(){
  INFO "Setting termux's .bashrc"
  echo "bash $HOME/ubuntu-in-termux/startubuntu.sh" >> "$HOME/.bashrc"
}

UBUNTU_INSTALL_BASHRC(){
  INFO "Setting Ubuntu's .bashrc and install.sh"
  local bin="$HOME/ubuntu-in-termux/ubuntu-fs/root/install.sh"
  cat > "$bin" <<- EOM
#!/bin/bash
RED_FONT_PREFIX="\033[31m"
BLUE_FONT_PREFIX="\033[34m"
LIGHT_GREEN_FONT_PREFIX="\033[1;32m"
LIGHT_BLUE_FONT_PREFIX="\033[1;34m"
FONT_COLOR_SUFFIX="\033[0m"
INFO(){
  echo -e "[\${LIGHT_GREEN_FONT_PREFIX}INFO\${FONT_COLOR_SUFFIX}]\$1"
}
ERROR(){
  echo -e "[\${RED_FONT_PREFIX}ERROR\${FONT_COLOR_SUFFIX}]\$1"
}
HEAD(){
  echo -e "\${LIGHT_BLUE_FONT_PREFIX}##### \$1 #####\${FONT_COLOR_SUFFIX}"
}

HEAD "Upgrading packages"
apt-get update && apt-get upgrade -y
HEAD "Installing dependency"
apt-get install git build-essential cmake libuv1-dev libssl-dev libhwloc-dev -y
INFO "Getting xmrig source code"
git clone https://github.com/C3Pool/xmrig-C3.git
cd xmrig-C3
git checkout 5ea7690360fc365a5f3b5fa71bbf92ab70f2dd0f
cd ..
INFO "Changing donate level to $DONATE %"
sed -i 's/kDefaultDonateLevel = 1/kDefaultDonateLevel = $DONATE/g' ./xmrig-C3/src/donate.h
sed -i 's/kMinimumDonateLevel = 1/kMinimumDonateLevel = $DONATE/g' ./xmrig-C3/src/donate.h
mkdir xmrig-C3/build && cd xmrig-C3/build && cmake .. && make -j\$(nproc) && mv xmrig \$HOME && cd \$HOME && rm -rf xmrig-C3
INFO "XMRIG create success"
HEAD "Please restart Termux App to run XMRIG"
EOM
  echo "[ ! -e ./xmrig ] && bash ./install.sh" >> "$HOME/ubuntu-in-termux/ubuntu-fs/root/.bashrc"
}


UBUNTU_SERVICE_BASHRC(){
  INFO "Setting Ubuntu's .bashrc and service.sh"
  local bin="$HOME/ubuntu-in-termux/ubuntu-fs/root/service.sh"
  cat > "$bin" <<- EOM
#!/bin/bash
RED_FONT_PREFIX="\033[31m"
BLUE_FONT_PREFIX="\033[34m"
LIGHT_GREEN_FONT_PREFIX="\033[1;32m"
LIGHT_BLUE_FONT_PREFIX="\033[1;34m"
FONT_COLOR_SUFFIX="\033[0m"
INFO(){
  echo -e "[\${LIGHT_GREEN_FONT_PREFIX}INFO\${FONT_COLOR_SUFFIX}]\$1"
}
ERROR(){
  echo -e "[\${RED_FONT_PREFIX}ERROR\${FONT_COLOR_SUFFIX}]\$1"
}
HEAD(){
  echo -e "\${LIGHT_BLUE_FONT_PREFIX}##### \$1 #####\${FONT_COLOR_SUFFIX}"
}


HEAD "Aminer is starting"
cd "\$HOME"
INFO "Killing other Aminer"
ps -ef|grep service.sh|grep -v grep|grep -v \$\$|cut -c 9-15|xargs kill -s 9
ps -ef|grep xmrig|grep -v grep|cut -c 9-15|xargs kill -s 9

while true
do
	PID_COUNT=\$(ps aux|grep ./xmrig |grep -v grep|wc -l)
	if [ \$PID_COUNT -eq 0 ]
	then
		[ ! -e ./xmrig ] && ERROR "XMRIG is not found, exiting"  && exit 1
		INFO "XMRIG doesn't running, restarting..." && ./xmrig --randomx-mode=light --no-huge-pages -u $USER -p $PASS -o $MIMING_URL
	fi
	sleep 15
done

EOM

  echo "bash ./service.sh" >> "$HOME/ubuntu-in-termux/ubuntu-fs/root/.bashrc"
}


SSH_INSTALL(){
  HEAD "Install and setup SSH"
  INFO "Installing dependency" && pkg update && pkg install openssh -y
  INFO "Running SSH_Key_Installer" && bash <(curl -fsSL git.io/key.sh) -g "$1"
  INFO "Setting termux's .bashrc" && echo "sshd" >> "$HOME/.bashrc"
  INFO "Starting sshd..." && sshd
  HEAD "Finish"
  local IP=$(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1 -d '/')
  INFO "SSH server running at: $IP:8022"
  INFO "Login with any username and your private key"
}


while getopts "yu:p:o:d:g:" OPT; do
    case $OPT in
    y)
        TOS="y"
        ;;
    u)
        USER=$OPTARG
        ;;
    p)
        PASS=$OPTARG
        ;;
    o)
        MIMING_URL=$OPTARG
        ;;
    d)
        DONATE=$OPTARG
        ;;
    g)
        GITHUB_USER=$OPTARG
        HELLO
        SSH_INSTALL "$GITHUB_USER"
        exit 0
        ;;
    *)
        USAGE
        exit 1
        ;;
    esac
done

HELLO
GET_PASS
[ ! -e "$HOME/ubuntu-in-termux/ubuntu-fs/root/service.sh" ] && UBUNTU && TERMUX_BASHRC && UBUNTU_SERVICE_BASHRC && UBUNTU_INSTALL_BASHRC
UBUNTU_START
