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

add_to_bashrc(){
  echo "$1" >> ~/.bashrc
}

autostart_ubuntu(){
  local command=""
  add_to_bashrc "$command"
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
    u)
        KEY_URL=$OPTARG
        get_url_key
        install_key
        ;;
    f)
        KEY_PATH=$OPTARG
        get_loacl_key
        install_key
        ;;
    p)
        SSH_PORT=$OPTARG
        change_port
        ;;
    d)
        disable_password
        ;;
    ?)
        USAGE
        exit 1
        ;;
    :)
        USAGE
        exit 1
        ;;
    *)
        USAGE
        exit 1
        ;;
    esac
done

if [ ! -x "$HOME/ubuntu-in-termux/ubuntu-fs/root/service.sh" ]; then
  install_ubuntu
  service_bash
fi