#!/usr/bin/env bash

install_ubuntu(){
  local command="apt-get update && apt-get upgrade -y"
  command+=" && apt-get install wget proot git -y"
  command+=" && cd ~"
  command+=" && git clone https://github.com/MFDGaming/ubuntu-in-termux.git"
  command+=" && cd ubuntu-in-termux"
  command+=" && bash ubuntu.sh -y"
  command+=" && cd ~"
  command+=" && ./startubuntu.sh"
  exec "$command"
}

add_to_bashrc(){
  echo "$1" >> ~/.bashrc
}

autostart_ubuntu(){
  local command=""
  add_to_bashrc "$command"
}

install_ubuntu
echo "已经在执行了"

