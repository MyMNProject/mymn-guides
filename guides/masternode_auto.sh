#!/bin/bash
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
sudo apt-get install git -y
sudo apt-get install nano -y
sudo apt-get install curl -y
sudo apt-get install pwgen -y
sudo apt-get install wget -y
sudo apt-get install build-essential libtool automake autoconf -y
sudo apt-get install autotools-dev autoconf pkg-config libssl-dev -y
sudo apt-get install libgmp3-dev libevent-dev bsdmainutils libboost-all-dev -y
sudo apt-get install libzmq3-dev -y
sudo apt-get install libminiupnpc-dev -y
sudo add-apt-repository ppa:bitcoin/bitcoin -y
sudo apt-get update -y
sudo apt-get install libdb4.8-dev libdb4.8++-dev -y

cd
#remove old files
sudo rm /usr/local/bin/mymn*
sudo rm mymn*
#get wallet files
sudo wget https://github.com/MyMNProject/mymn/releases/download/1.2.1.1-nobootstrap/mymn-linux.tar.gz
sudo tar -xvf mymn-linux.tar.gz
# make new directory
sudo mkdir $HOME/.mymn
#remove old boostrap file
sudo rm bootstrap*
#sudo wget https://github.com/MyMNProject/mymn/releases/download/1.2.1.1-nobootstrap/mymn-linux.tar.gz
sudo wget https://github.com/MyMNProject/mymn/releases/download/1.2.1.1-nobootstrap/bootstrap-linux-146k.tar.gz

#extract files to data folder
sudo tar -xvf bootstrap-linux-146k.tar.gz -C $HOME/.mymn/ --strip-components=1
# clean up files
sudo rm bootstrap*
sudo rm mymn-linux* masternode_auto.sh
sudo chmod +x mymn*
sudo chmod +x bootstrap-linux*
sudo cp mymn* /usr/local/bin
sudo ufw allow 10261/tcp

#masternode input

echo -e "${GREEN}Now paste your Masternode key by using right mouse click and press ENTER ${NONE}";
read MNKEY 

EXTIP=`curl -s4 icanhazip.com`
USER=`pwgen -1 20 -n`
PASSW=`pwgen -1 20 -n`

echo -e "${GREEN}Preparing config file ${NONE}";

printf "addnode=85.255.3.43:10261\naddnode=81.2.240.125:10261\naddnode=139.99.168.121:10261\naddnode=139.99.159.77:10261\naddnode=139.99.197.112:10261\naddnode=139.99.197.135:10261\naddnode=139.99.196.73:10261\naddnode=139.99.158.38:10261\n\nrpcuser=mymn$USER\nrpcpassword=$PASSW\\ndaemon=1\nlisten=1\nrpcport=66541\nrpcallowip=127.0.0.1\nserver=1\nmaxconnections=154\nexternalip=$EXTIP:10261\nmasternode=1\nmasternodeprivkey=$MNKEY" >  $HOME/.mymn/mymn.conf

mymnd
watch mymn-cli getinfo



