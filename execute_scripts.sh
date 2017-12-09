#cd shell_scripts
for i in *
do
	extension=`echo $i | cut -f2 -d"." `

	if [ extension=sh ]
		then
			#chmod 777 $i
			echo $i
		fi
	done
