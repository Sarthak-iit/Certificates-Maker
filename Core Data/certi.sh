#! /bin/sh
#in Core data directory
data_git_repo_name=`python3 variables.py data_git_repo_name`
web_git_repo_name=`python3 variables.py web_git_repo_name`
data_git_repo_link=`python3 variables.py data_git_repo_link`
year=`python3 variables.py year`

if test -d $data_git_repo_name
then
	echo "Website directories exist"
else
	cd ../
	git clone $data_git_repo_link
	cd "Core Data"
	echo "Website directories created"
fi

echo "Enter which category is it?('Technical' , 'Cultural' , 'Informal' , 'Workshops')"
read category
while [ $category != "Technical" -a $category != "Cultural" -a $category != "Informal" -a $category != "Workshops" ]
do
	echo "Choose from 'Technical' , 'Cultural' , 'Informal' , 'Workshops'"
	read category
done

echo "Do you want to update or create new?(Update/Create)"
read update
while [ $update != "Update" -a $update != "Create" -a $update != "Cre" -a $update != "Upd" ]
do
	echo "Do you want to update or create new?(Update/Create)"
	read update
done
if [ $update == "Update" ] || [ $update == "Upd" ]
then
	if [ $category == "Workshops" ]
	then
		bash update_workshops.sh
		echo 'bey'
		exit
	fi
	if [ $category == "Technical" ] || [ $category == "Cultural" ] || [ $category == "Informal" ]
	then 
		export category
		bash update_events.sh
		exit
	fi
fi
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

export category
if [ $category == "Technical" ] || [ $category == "Cultural" ] || [ $category == "Informal" ]
then 
	export category
	bash event.sh
fi
if [ $category == "Workshops" ]
then 
	bash workshop.sh
fi










 
