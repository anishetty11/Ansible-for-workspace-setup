
Workspace automation using ansible and shell scripts

This project helps system administrators to easily download softwares, and run shell scripts on several machines at a time remotely. 
All the machines which are present in the same network and are accessible through SSH are scanned automatically. The system admin only needs to mention the names of the softwares to be downloaded (if present in apt repository), or write a shell script to download the package and dependencies and place them in a particular folder. All the packages will be downloaded on the remote hosts, and the scripts placed in the folder will be executed.

Usage:

1. Execute the "setup.sh" script.
  The script installs the required dependencies and places all the contents in a folder named "ansible" on the desktop
  The asks the user if proxy server has to be setup, and the user the do so accordingly.
  
2. Getting the hosts.
  If the number of remote hosts in the workspace is less, they can be manually entered in the "hosts" file.
  However, if there are many number of hosts, "get_ip.sh" script could be executed, which scans the entire subnet, and places all the       accesible remote hosts in the "hosts" file.
  
3. Defining the softwares to be installed.
  Few of the commonly used softwares such as "Vim", "Git" and other have already been placed in a file named "main.yml"                     (roles/basic/tasks/main.yml). These files will be automatically downloaded on the remote hosts, when the ansible script is executed.
  However if the user wishes to add more softwares, he can do so by executing the "add_software.sh" script,  and pass the name/s of the     softwares to be installed as Command Line Arguments. The script checks if the software named are valid, and present in the apt           repository. And if they are present, they are added onto the "main.yml" file.
  
4. Adding softwares not present in apt repository
  Not all of the softwares are present in the apt repository. Additionally certain softwares may need several dependencies.
  In such cases, a shell script could be written to install these softwares, and could be placed in the "shell_scripts" folder.
  All the script present in this folder, will be executed in the remote devices. Thereby downloading the softwares onto them.
  
5. Execting the ansible script
  Finally, the ansible playbook script could be executed as follows
  "ansible-playbook -K playbook.yml"
  On executing this script, the instuctions specified in the "main.yml" file will be executed on by one, on all of the remote devices.       Thereby downloading the softwares and setting up the configurations (if any)
