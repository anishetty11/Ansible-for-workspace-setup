
if [[ $# -lt 1 ]]
	then
	 	echo "Atleast one package has to specified as CLA"
fi

for i in $@
do
	apt-cache show $i > /dev/null 2>&1
	if [[ $? -ne 0 ]]
	then
		echo "#############################################"
		echo " THE PACKAGE '$i' IS NOT PRESENT IN APT_GET REPOSITORY"
		echo " PLEASE ENTER A VALID PACKAGE NAME"
	else
		cat roles/basic/tasks/main.yml | grep -B100 /etc/apt | grep $i > /dev/null
		if [[ $? -ne 0 ]]
			then
				awk -v i="  - $i" '{print $0;if(NR==4){print i}}' roles/basic/tasks/main.yml > temp.txt
				echo " Package $i has been added to main.yml"
			else
				echo " Package $i already present in the main.yml"
			fi
		fi
		echo
		cp temp.txt roles/basic/tasks/main.yml
	done

rm temp.txt

