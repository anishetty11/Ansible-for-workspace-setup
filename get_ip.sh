#!/bin/sh

###########################################################
#
# Program to scan all IP adresses in the network
#
# And,check whether SSH is enabled, and copy the SSH-key
#
# Assuming the device has been assigned IP address of mask
# 255.255.255.0
#
###########################################################

# get the ip details
enp3s0=`ifconfig| grep -A 2 "enp.s." `
#echo $enp3s0

# extract the first three octects of IP address
re="inet addr:(.*)\..* B"
if [[ $enp3s0 =~ $re ]]
	then
		ip=${BASH_REMATCH[1]}
fi

ip="$ip."
#echo $ip

# prompt the user for password of the hosts
echo "Enter the passwords for logging in to the hosts"
read passwd

# create a file called "ignored_hosts" to list the hosts that have been
# ignored

echo "These hosts have been ignored" | cat > ignored_hosts

# for each ip in that network, try to copy the ssh authentication key
for i in {85..255}
do
	
	temp_ip="$ip$i"
	echo " ** checking the host $temp_ip"
	
	# try to copy the ssh key. If succesful, 0 is returned. Else, non zero is returned.
	timeout 3 sshpass -p $passwd ssh-copy-id -o StrictHostKeyChecking=no $temp_ip > /dev/null 2>&1

		# if ssh key is copied succesfully, add the IP address, to the "hosts" list
		if [[ $? -eq 0 ]]
			then
				# check if the IP address is already present in the hosts
				cat hosts | grep $temp_ip > /dev/null

				# if not present, then add it to hosts list
				if [[ $? -eq 0 ]]
					then
					echo "Added $temp_ip to the hosts list"
					echo $temp_ip | cat >> hosts
				fi
			# if ssh not enabled, or ssh key couldn't be copied, add the IPs to a file called
			# 'ignored_hosts'
			else
				echo $temp_ip | cat >> ignored_hosts
		fi


	
done
