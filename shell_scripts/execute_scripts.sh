#cd shell_scripts

# move into the directory containing the scripts
cd ~/Desktop/shell_scripts/

#for each file in the directory
for i in *
do
	# extract filename and extension
	extension=`echo $i | cut -f2 -d"." `
	fname=`echo $i | cut -f1 -d"." `
	
	# if extension is '.sh' then execture the script
	if [ $extension = "sh" ]
		then
		# check if the filename is "execute_scripts"
		# to prevent infinite loop
		if [ $fname != "execute_scripts" ]
			then
			chmod 777 $i
			# execute the script
			bash $i
			pwd
		fi
	fi
done
