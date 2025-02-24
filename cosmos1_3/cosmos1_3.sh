#!/bin/bash
# Install Cosmos + create systemd service ,run and sync Cosmos Hub 3, by Víctor from melea "Genesis Cosmos Validator"

USER=$(whoami)
sudo apt-get update
sudo apt install build-essential
git clone https://github.com/cosmos/gaia.git
cd gaia
git checkout v2.0.8
make install
gaiad init Node-Name-here --chain-id cosmoshub-3
sleep 3
gaiad version --long
sleep 3
sudo chmod -R 777 /home/$USER/.gaiad
cd /home/$USER/.gaiad/config/
rm genesis.json
wget https://raw.githubusercontent.com/cosmos/launch/master/genesis.json
cd
sed -E -i 's/seeds = \".*\"/seeds = \"3e16af0cead27979e1fc3dac57d03df3c7a77acc@3.87.179.235:26656,ba3bacc714817218562f743178228f23678b2873@public-seed-node.cosmoshub.certus.one:26656,2626942148fd39830cb7a3acccb235fab0332d86@173.212.199.36:26656,3028c6ee9be21f0d34be3e97a59b093e15ec0658@91.205.173.168:26656,89e4b72625c0a13d6f62e3cd9d40bfc444cbfa77@34.65.6.52:26656\"/' ~/.gaiad/config/config.toml
sed -E -i 's/persistent_peers = \".*\"/persistent_peers = \"e4f5becb53b568bfd18c7f086dada943f768bc7a@34.244.129.193:26656,94375d3642bf7366bb50f1d91dbeda70b013e6a1@34.255.217.37:26656,aacf186a5a711b1fe511a25e451c1ddbce2d8e4b@8.9.4.245:26656\"/' ~/.gaiad/config/config.toml
sed -E -i 's/minimum-gas-prices = \".*\"/minimum-gas-prices = \"0.025uatom\"/' ~/.gaiad/config/app.toml
sudo mkdir -p /var/log/gaiad
sudo touch /var/log/gaiad/gaiad.log
sudo touch /var/log/gaiad/gaiad_error.log
cat <<EOF > gaiad.service
[Unit]
Description=gaiad daemon
After=network-online.target

[Service]
ExecStart=/home/$USER/go/bin/gaiad start --home=/home/$USER/.gaiad/
StandardOutput=file:/var/log/gaiad/gaiad.log
StandardError=file:/var/log/gaiad/gaiad_error.log
Restart=always
RestartSec=3
LimitNOFILE=4096

[Install]
WantedBy=multi-user.target
EOF

sudo mv gaiad.service /etc/systemd/system

sudo systemctl daemon-reload
sudo systemctl enable gaiad
sudo systemctl start gaiad
sleep 2
tail -f /var/log/gaiad/gaiad.log