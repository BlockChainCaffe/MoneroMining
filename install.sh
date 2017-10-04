########################################################
#
# Monero CPU Miner Installer script
#
########################################################

WALLET_ADDRESS=42WaLsGbVXA4xRtDw7JgZXPCQgB7ZqzPWUDHY3TiP6TM6vyWV1iMx3hdUo5CmR2eCqRh6MkHj7viJb2vJdsfY5rgCnmAfsP
CPU=$(cat /proc/cpuinfo | grep processor | wc -l)
[[ $CPU > 3 ]] && CPU=$(( CPU - 2 )) || CPU=1 

################
# INSTALL

sudo apt-get install git libcurl4-openssl-dev build-essential libjansson-dev autotools-dev automake
git clone https://github.com/hyc/cpuminer-multi
cd cpuminer-multi
./autogen.sh
CFLAGS="-march=native" ./configure
make
PRGDIR=$(pwd)

##############
# RUN-SCRIPT

cat > ~/mine.sh << EOF
#!/bin/bash
cd $PRGDIR
sudo ./minerd -a cryptonight -o stratum+tcp://pool.minexmr.com:4444 -u $WALLET_ADDRESS -p x -t $CPU
EOF
chmod +x ~/mine.sh
