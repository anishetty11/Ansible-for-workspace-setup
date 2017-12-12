########################################################################
# Program to allow admins to add more softwares to the main.yml file
#
# The program takes the packages as CLAs
# e.g. ./add_software package1 package2
#
##########################################################################

#check if atleast 1 package has been specified
if [[ $# -lt 1 ]]
	then
	 	echo "Atleast one package has to specified as CLA"
fi


# go through each of the packages one by one
for i in $@
do
	# check if such a package is available in the apt-get cache
	apt-cache show $i > /dev/null 2>&1

	# if such a package doesn't exists, notify the user about it
	if [[ $? -ne 0 ]]
	then
		echo "****************************************************"
		echo " THE PACKAGE '$i' IS NOT PRESENT IN APT_GET REPOSITORY"
		echo " PLEASE ENTER A VALID PACKAGE NAME"
	
	# if such a package exists, check if the package is already present 
	# in the main.yml file
	else
		# to check if the package is already present in main.yml
		cat roles/basic/tasks/main.yml | grep -B100 /etc/apt | grep $i > /dev/null
		
		# if not present, add it to the main.yml file
		if [[ $? -ne 0 ]]
			then
				#awk -v i="  - $i" '{print $0;if(NR==11){print i}}' roles/basic/tasks/main.yml > temp.txt
				awk -v i="  - $i" '{print $0;if($1=="with_items:"){print i}}' roles/basic/tasks/main.yml > temp.txt
				echo " Package $i has been added to main.yml"
				cp temp.txt roles/basic/tasks/main.yml
			# if already present, ignore
			else
				echo " Package $i already present in the main.yml" 2>/dev/null
			fi
		fi
		echo
		
	done

rm temp.txt

