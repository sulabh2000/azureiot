read -p "Enter the Resource Group Name : " rs
read -p "Enter the Location : " la
read -p "Enter the IOT Hub Name : " iname
read -p "Enter the Device Name : " dname
#Add iot extension to cli
az extension add --name azure-cli-iot-ext
#Create resource group
az group create --name $rs --location $la
#Create Azure iot Hub
az iot hub create --resource-group $rs --name $iname --sku S1
#Create Edge device identity 
az iot hub device-identity create --hub-name $iname --device-id $dname --edge-enabled
#Retrieve the connection string
az iot hub device-identity show-connection-string --hub-name $iname --device-id $dname
