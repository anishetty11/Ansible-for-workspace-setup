# Program to install the dependencies, and set up the config files
# Creates a directory called as "ansible" on the Desktop, and places all
# the files in the folder


#mkdir ~/Desktop/ansible
#mv * ~/Desktop/ansible

sudo apt-get install ansible
sudo apt-get -y install sshpass

ssh-keygen -t rsa

get_proxy()
{
	echo "Enter the proxy server address and port no"
	echo "e.g. 172.16.19.10:80"
	read proxy
	if [[ $proxy =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}:[0-9]{2,4}$ ]]
	then 
		echo return
	else
		echo "Proxy address seems to be wrong.Please try again"
		get_proxy
	fi	

}




echo "Proxy address needs to be set up? y/n?"
read choice
if [[ $choice =~ [y/Y] ]]
	then
		get_proxy
		echo Acquire::http::Proxy \"http://$proxy\"\; | cat > ~/Desktop/ansible/configfiles/apt.conf
		echo Acquire::https::Proxy \"https://$proxy\"\; | cat >> ~/Desktop/ansible/configfiles/apt.conf
		echo http_proxy=\"http://$proxy\"\; | cat >> ~/Desktop/ansible/configfiles/docker
		echo https_proxy=\"https://$proxy\"\; | cat >> ~/Desktop/ansible/configfiles/docker

	else
		echo "" | cat > ~/Desktop/ansible/configfiles/apt.conf
fi




echo "Setup has been completed"
echo "Refer the readme file or more instructions"
echo "You can get the readme file in the 'ansible' "
echo "folder in the Desktop"


