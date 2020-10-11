#!/bin/bash

computername="rabbitmq-node1 rabbitmq-node2 rabbitmq-node3"

ResourGroup_setup="rmqRG"

i=1

echo "Preparing inventory files for ansible-playbook command...."

echo -e "IPaddress reference file  inventory/hosts"


echo "[allnodes]" > inventory/inventory.yaml


for nodein in $computername

do

azip=`az vm list-ip-addresses -g $ResourGroup_setup  -n $nodein --query [0].virtualMachine.network.publicIpAddresses[0].ipAddress | cut -d '"' -f 2`

echo $azip >> inventory/inventory.yaml

echo "$azip node0$i" 

i=$(($i + 1))

done

echo -e "\n[master]" >> inventory/inventory.yaml

sed -n 2p inventory/inventory.yaml >> inventory/inventory.yaml

echo -e "\n[slave]" >> inventory/inventory.yaml

sed -n 3p inventory/inventory.yaml >> inventory/inventory.yaml

sed -n 4p inventory/inventory.yaml >> inventory/inventory.yaml
