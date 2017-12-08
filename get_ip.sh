#!/bin/sh

###########################################################
#
# Program to scan all MAC adresses in the network
#
# Assuming the device has been assigned IP address of mask
# 255.255.255.0
#
###########################################################

# get the ip details
enp3s0=`ifconfig| grep -A 2 "enp1s0" `
#echo $enp3s0

# extract the first three octects of IP address
re="inet addr:(.*)\..* B"
if [[ $enp3s0 =~ $re ]]
	then
		ip=${BASH_REMATCH[1]}
fi

ip="$ip."
echo $ip


# for each ip in that network, request MAC addres
for i in {1..254}
do
	echo " ## $temp_ip"
	temp_ip="$ip$i"
	nmap -p22 $temp_ip | grep -A2 "PORT" | grep open > /dev/null

	if [[ $? -eq 0 ]]
		then
			sshpass -p "mclab@123" ssh-copy-id -o StrictHostKeyChecking=no $temp_ip > /dev/null 2>&1
			if [[ $? -eq 0 ]]
			then
				echo "Added $temp_ip to the hosts list"
				echo $temp_ip | cat >> hosts
			fi
		fi
	
done