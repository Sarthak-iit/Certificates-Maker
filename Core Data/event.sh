#!/bin/sh

#only for events
data_git_repo_name=`python3 variables.py data_git_repo_name`
web_git_repo_name=`python3 variables.py web_git_repo_name`
web_git_repo_link=`python3 variables.py web_git_repo_link`
year=`python3 variables.py year`

echo ${category}
cd ../
#change to main directory
main_dir="${PWD}"


echo "Enter event name(Caps sensitive)"
read event





category=${category}_Events
evnt_name_underscore=`python3 Core\ Data/underscore.py $event`

if test -d $web_git_repo_name
then
	if test -d $web_git_repo_name/$category/$year
	then
		echo "Website directories exist"
	else
		mkdir $web_git_repo_name/$category/$year
	fi
else
	git clone $web_git_repo_link
	if test -d $web_git_repo_name/$category/$year
	then
		echo "Website directories exist"
	else
		mkdir $web_git_repo_name/$category/$year
	fi
	echo "Website directories created"
fi

sudo mkdir ${data_git_repo_name}/$evnt_name_underscore
sudo mkdir ${data_git_repo_name}/$evnt_name_underscore/Participation_data
sudo mkdir ${data_git_repo_name}/$evnt_name_underscore/Participation_data/Participation
sudo mkdir ${data_git_repo_name}/$evnt_name_underscore/Participation_data/Participation/all_certificates
sudo mkdir ${data_git_repo_name}/$evnt_name_underscore/Winner_data
sudo mkdir ${data_git_repo_name}/$evnt_name_underscore/Winner_data/Winner
sudo mkdir ${data_git_repo_name}/$evnt_name_underscore/Winner_data/Winner/all_certificates

sudo cp "Core Data/main_new.py" "${data_git_repo_name}/$evnt_name_underscore/Participation_data"
sudo cp "Core Data/Date_Converter.py" "${data_git_repo_name}/$evnt_name_underscore/Participation_data"
sudo cp "Core Data/winner_new.py" "${data_git_repo_name}/$evnt_name_underscore/Winner_data"
sudo cp "Core Data/Date_Converter.py" "${data_git_repo_name}/$evnt_name_underscore/Winner_data"

sudo cp "Background/$event.png" "${data_git_repo_name}/$evnt_name_underscore/Participation_data/Participation/bg.png"
sudo cp "Background/$event.png" "${data_git_repo_name}/$evnt_name_underscore/Winner_data/Winner/bg.png"

sudo cp "Core Data/logo.png" "${data_git_repo_name}/$evnt_name_underscore/Participation_data/Participation/"
sudo cp "Core Data/logo.png" "${data_git_repo_name}/$evnt_name_underscore/Winner_data/Winner/"

sudo cp "Templates/$event.jpg" "${data_git_repo_name}/$evnt_name_underscore/Participation_data"
sudo cp "Templates/$event-1.jpg" "${data_git_repo_name}/$evnt_name_underscore/Winner_data"

sudo cp "Templates/$event-2.jpg" "${data_git_repo_name}/$evnt_name_underscore/Winner_data"
sudo cp "Templates/$event-3.jpg" "${data_git_repo_name}/$evnt_name_underscore/Winner_data"
sudo cp "Templates/$event-4.jpg" "${data_git_repo_name}/$evnt_name_underscore/Winner_data"
sudo cp "Templates/$event-5.jpg" "${data_git_repo_name}/$evnt_name_underscore/Winner_data"
sudo cp "Templates/$event-6.jpg" "${data_git_repo_name}/$evnt_name_underscore/Winner_data"
sudo cp "CSV Files/$event.csv" "${data_git_repo_name}/$evnt_name_underscore/Participation_data"
sudo cp "CSV Files/$event.csv" "${data_git_repo_name}/$evnt_name_underscore/Winner_data"
sudo cp "Core Data/STIXTwoText-Regular.otf" "${data_git_repo_name}/$evnt_name_underscore/Participation_data"
sudo cp "Core Data/STIXTwoText-Regular.otf" "${data_git_repo_name}/$evnt_name_underscore/Winner_data"
echo "Do you want to send email?(If yes enter 'YES',if no type 'N')"
read email
if [ $email != "YES" -a $email != "N" -a $email != "No" ]
then
	while [ $email != "YES I WANT TO SEND EMAILS" -a $email != "N" -a $email != "No" ]
	do
		echo "Do you want to send email?(If yes enter 'YES I WANT TO SEND EMAILS',if no enter 'N')"
		read email
	done
fi
send=0
if [ $email == "YES" ]
then 
	send=1
fi
cd ${data_git_repo_name}/$evnt_name_underscore/Participation_data
echo "Do you want to send Participation Certificates?(If yes enter 'YES',if no type 'N')"
read partic
if [ $partic != "YES" -a $partic != "N" -a $partic != "No" ]
then
	while [ $partic != "YES" -a $partic != "N" -a $partic != "No" ]
	do
		echo "Do you want to send Participation Certificates?(If yes enter 'YES',if no type 'N')"
		read partic
	done
fi
if [ $partic == "YES" ]
then 
	sudo python3 main_new.py $event $send $category $year
fi
sudo mkdir "$main_dir/$web_git_repo_name/${category}/$year/${evnt_name_underscore}"
sudo cp -R "Participation" "$main_dir/$web_git_repo_name/${category}/$year/${evnt_name_underscore}"
cd "../Winner_data"
sudo python3 winner_new.py $event $send $category $year
sudo cp -R "Winner" "$main_dir/$web_git_repo_name/${category}/$year/${evnt_name_underscore}"

cd ../../
git pull
git add .
git commit -m "added the event ${event}"
git push

cd $main_dir/$web_git_repo_name/$category/
git pull
git add .
git commit -m "added the event ${event}"
git push