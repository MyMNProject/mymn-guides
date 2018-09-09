#!/bin/bash

cd
#remove old files
sudo rm /usr/local/bin/mymn*
rm mymn*
#get wallet files
wget https://github.com/MyMNProject/mymn-guides/raw/master/wallet/linux64/mymn-linux.tar.gz
sudo tar -xvf mymn-linux.tar.gz
sudo rm mymn-linux* mymn_auto.sh
sudo chmod +x mymn*
sudo cp mymn* /usr/local/bin
sudo ufw allow 10261/tcp

#masternode input

#echo -e "${GREEN}Now paste your Masternode key by using right mouse click and press ENTER ${NONE}";
#read MNKEY

EXTIP=`curl -s4 icanhazip.com`
USER=`pwgen -1 20 -n`
PASSW=`pwgen -1 20 -n`

echo -e "${GREEN}Preparing config file ${NONE}";

rm -rf $HOME/.mymn
sudo mkdir $HOME/.mymn

printf "addnode=139.99.168.121:10261\naddnode=139.99.159.113:10261\naddnode=139.99.159.77:10261\naddnode=139.99.197.112:10261\naddnode=139.99.197.135:10261\naddnode=139.99.196.73:10261\naddnode=139.99.202.60:10261\naddnode=139.99.158.38:10261\n\nrpcuser=mymn$USER\nrpcpassword=$PASSW\\ndaemon=1\nlisten=1\nrpcport=66541\nrpcallowip=127.0.0.1\nserver=1\nmaxconnections=54\nexternalip=$EXTIP:10261\nmasternode=1\nmasternodeprivkey=$MNKEY" >  $HOME/.mymn/mymn.conf

mymnd
watch mymn-cli getinfo

