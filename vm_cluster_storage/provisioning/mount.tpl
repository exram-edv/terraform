#!/bin/bash

# System aktualisieren
sudo apt-get -y update
sudo apt-get -y upgrade

# mounten einer Dateifreigabe eines Azure Storage Accounts auf den nodes
#
# Parameter:
# storage_account
# storage_key
# storage_share
# 
sudo mkdir /mnt/${storage_share}
sudo mount -t cifs //${storage_account}.file.core.windows.net/${storage_share} /mnt/${storage_share} -o vers=3.0,username=${storage_account},password=${storage_key},dir_mode=0777,file_mode=0777
echo "//${storage_account}.file.core.windows.net/${storage_share} /mnt/${storage_share} cifs vers=3.0,username=${storage_account},password=${storage_key},dir_mode=0777,file_mode=0777,serverino" | sudo tee -a /etc/fstab


