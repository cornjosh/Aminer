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

install_ubuntu
start_ubuntu
echo "已经在执行了"

