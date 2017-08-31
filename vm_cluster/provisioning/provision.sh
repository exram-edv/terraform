#!/bin/bash
sudo apt-get -y update
sudo apt-get -y upgrade

# mounten einer Dateifreigabe eines Azure Storage Accounts auf den nodes
#
# $1: Username
# $2: Key
# $3: share
# 
sudo mkdir /mnt/$3
sudo mount -t cifs //$1.file.core.windows.net/$3 /mnt/$3 -o vers=3.0,username=$1,password=$2,dir_mode=0777,file_mode=0777
echo "//$1.file.core.windows.net/$3 /mnt/$3 cifs vers=3.0,username=$1,password=$2,dir_mode=0777,file_mode=0777,serverino" | sudo tee -a /etc/fstab


