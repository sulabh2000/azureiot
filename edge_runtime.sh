#!/bin/bash
echo "Installing the repository configurations....."
curl https://packages.microsoft.com/config/ubuntu/18.04/multiarch/prod.list > ./microsoft-prod.list
echo "Copying the generated list....."
sudo cp ./microsoft-prod.list /etc/apt/sources.list.d/
echo "Installing Microsoft GPG public key....."
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo cp ./microsoft.gpg /etc/apt/trusted.gpg.d/
echo "Installing Moby-Engine....."
sudo apt-get update
sudo apt-get install moby-engine -y
echo "Installing Moby-Cli....."
sudo apt-get install moby-cli -y
echo "Installing the Azure IoT Edge Security Daemon....."
sudo apt-get update
sudo apt-get install iotedge -y
echo "Provisioning the Device....."
read -p "Enter the Connection String : " name
sudo sed -i 's|"<ADD DEVICE CONNECTION STRING HERE>"|"'$name'"|' /etc/iotedge/config.yaml
echo "Restarting the deamon....."
sudo systemctl restart iotedge
echo "Enabling the services....."
sudo systemctl enable iotedge
echo "Checking the status....."
systemctl status iotedge
echo "Examining the deamon logs....."
journalctl -u iotedge --no-pager --no-full
sudo iotedge check
echo  "Finally listing running modules....."
sudo iotedge list
