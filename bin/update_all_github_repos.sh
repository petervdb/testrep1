#!/bin/bash
# I use this script to update all my GIT Repositories that are available on the running system
#
GIT_HOME=$HOME/GitHub
echo "I will perform a pull request for the following repositories:"
repos=`ls $GIT_HOME`
ls -1 $GIT_HOME
echo ""
echo "Do you want me to continue? Y/N :"
read check
if [ $check = "Y" ]
then
	echo "Will start pulling these repositories"
	for repository in $repos
	do
		echo "Performing git pull of $repository"
		cd $GIT_HOME/$repository
		git pull origin master
		echo "Pull request completed"
		echo "------------------------------------------------------------------------------------"
	done
	echo "Finished."
else
	echo "OK, exiting now ..."
fi
