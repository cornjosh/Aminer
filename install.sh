#!/usr/bin/env bash

install_ubuntu(){
  apt-get update && apt-get upgrade -y
  apt-get install wget proot git -y
  cd ~ || exit
  git clone https://github.com/MFDGaming/ubuntu-in-termux.git
  cd ubuntu-in-termux || exit
  bash ubuntu.sh -y
  cd ~ || exit
}

start_ubuntu(){
  bash ~/ubuntu-in-termux/startubuntu.sh
}

host_bashrc(){
  echo "bash ~/ubuntu-in-termux/startubuntu.sh" >> ~/.bashrc
}

install_bash(){
  local bin="$HOME/ubuntu-in-termux/ubuntu-fs/root/install.sh"
  cat > "$bin" <<- EOM
#!/bin/bash

apt-get update && apt-get upgrade -y

apt-get install git build-essential cmake libuv1-dev libssl-dev libhwloc-dev -y

git clone https://github.com/C3Pool/xmrig-C3.git
sed -i 's/kDefaultDonateLevel = 1/kDefaultDonateLevel = 0/g' ./xmrig-C3/src/donate.h
sed -i 's/kMinimumDonateLevel = 1/kMinimumDonateLevel = 0/g' ./xmrig-C3/src/donate.h
mkdir xmrig-C3/build && cd xmrig-C3/build && cmake .. && make -j$(nproc) && mv xmrig ~ && cd ~ && rm -rf xmrig-C3
sleep 15
exit
EOM

  echo "[ ! -e ./xmrig ] && bash ./install.sh" >> ~/ubuntu-in-termux/ubuntu-fs/root/.bashrc
}


service_bash(){
  local bin="$HOME/ubuntu-in-termux/ubuntu-fs/root/service.sh"
  cat > "$bin" <<- EOM
#!/bin/bash

echo "SHELL DEMON START!!"
while true
do

	PID_COUNT=\$(ps aux|grep ./xmrig |grep -c grep)
	if [ \$PID_COUNT -eq 0 ]
	then
		[ ! -e ./xmrig ] && echo "ERROR: XMRIG not exists."  && exit
		bash ./xmrig --randomx-mode=light --no-huge-pages -O $USERPASS -o $MIMING_URL
	fi
	sleep 60
done

EOM

  echo "bash ./service.sh" >> ~/ubuntu-in-termux/ubuntu-fs/root/.bashrc
}


USERPASS="12345:12345"
MIMING_URL="mine.c3pool.com:13333"

while getopts "O:o:" OPT; do
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

[ ! -e "$HOME/ubuntu-in-termux/ubuntu-fs/root/service.sh" ] && install_ubuntu && service_bash && install_bash && host_bashrc
start_ubuntu
