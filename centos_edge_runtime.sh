#!/bin/bash
echo "Downloading the Packages......"
echo "Downloading moby-cli..."
wget https://packages.microsoft.com/centos/7/prod/moby-cli-3.0.10%2Bazure-0.x86_64.rpm
echo "Downloading moby-engine..."
wget https://packages.microsoft.com/centos/7/prod/moby-engine-3.0.10%2Bazure-0.x86_64.rpm
echo "Downloading other packages..."
wget https://github.com/Azure/azure-iotedge/releases/download/1.0.9/libiothsm-std_1.0.9-1.el7.x86_64.rpm
wget https://github.com/Azure/azure-iotedge/releases/download/1.0.9/iotedge-1.0.9-1.el7.x86_64.rpm
echo "Installation Starts......"
sudo yum install moby-cli-3.0.10+azure-0.x86_64.rpm
sudo yum install moby-engine-3.0.10+azure-0.x86_64.rpm
sudo rpm -Uhv libiothsm-std_1.0.9-1.el7.x86_64.rpm
sudo rpm -Uhv iotedge-1.0.9-1.el7.x86_64.rpm
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
