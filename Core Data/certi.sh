#! /bin/sh
#in Core data directory
data_git_repo_name=`python3 variables.py data_git_repo_name`
web_git_repo_name=`python3 variables.py web_git_repo_name`
year=`python3 variables.py year`


echo "This script is only supposed to be used the first time, for updating use the update.sh bash script.Do you want to continue?(Y/N)"
read continue
while [ $continue != "Y" -a $continue != "N" ]
do
	echo "Do you want to continue?(Y/N)"
	read continue
done
echo $continue
if [ $continue == "N" ]
then 
	echo yes
	exit
fi


echo "Enter which category is it?('Technical' , 'Cultural' , 'Informal' , 'Workshops')"
read category
while [ $category != "Technical" -a $category != "Cultural" -a $category != "Informal" -a $category != "Workshops" ]
do
	echo "Choose from 'Technical' , 'Cultural' , 'Informal' , 'Workshops'"
	read category
done
export category
if [ $category == "Technical" ] || [ $category == "Cultural" ] || [ $category == "Informal" ]
then 
	bash event.sh
fi
if [ $category == "Workshops" ]
then 
	sudo bash workshop.sh
fi










 
