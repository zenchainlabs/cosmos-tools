#This script Install Cosmos + create systemd service and run and sync CosmosHub 4.
#Firewal need open 26656 for p2p before run

1.-- $ wget https://raw.githubusercontent.com/enkrypter/cosmos-tools/master/cosmos4/cosmos4.sh

2.-- $ chmod +x ./cosmos4.sh

3.-- $ ./cosmos4.sh


#if everything goes well you will end up seeing the logs of the gaiad service, now you can cut them with Ctrl+c

#Check the logs from the node

$ tail -f /var/log/gaiad/gaiad.log

#Service logs

$ sudo journalctl -u gaiad -f

Pics:

![image](https://meleatrust.com/wp-content/uploads/2020/03/Screenshot-from-2020-03-03-19-48-02.png)
![image](https://meleatrust.com/wp-content/uploads/2020/03/Screenshot-from-2020-03-03-19-47-21.png)
![image](https://meleatrust.com/wp-content/uploads/2020/03/Screenshot-from-2020-03-03-19-48-33.png)

Guides:

[Cosmos systemd Guide](https://medium.com/@meleacrypto/systemd-to-manage-the-atom-cosmos-node-fda482999f4a)
&
[Cosmos Guide](https://medium.com/@meleacrypto/atom-cosmos-hub-3-tutorial-be-your-own-crypto-bank-838b37fe1c86)

# cheers
