#!/bin/bash
sudo apt install wget -y
rustup update
sudo systemctl stop aleo
cd $HOME/snarkOS
git fetch
git checkout v1.3.13
cargo build --release --verbose
rm -rf $HOME/.snarkOS/snarkos_testnet1
rm -rf $HOME/.snarkOS/snarkos_testnet1_secondary
cd

#update snapshot
block=380000
wget 188.166.34.137/backup_snarkOS_$block.tar.gz
tar xvf backup_snarkOS_$block.tar.gz
mv backup_snarkOS_$block/.snarkOS/* $HOME/.snarkOS/
rm -rf backup_snarkOS_$block*

sudo systemctl start aleo

version=`$HOME/snarkOS/target/release/snarkos help | grep snarkOS | head -n 1`
echo 'Current version' $version