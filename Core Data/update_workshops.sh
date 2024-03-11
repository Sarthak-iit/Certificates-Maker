#!/bin/sh
#only for workshops

data_git_repo_name=`python3 variables.py data_git_repo_name`
web_git_repo_name=`python3 variables.py web_git_repo_name`
year=`python3 variables.py year`

category="Workshops"
cd ../
#change to main directory
main_dir= `pwd`

echo "Enter workshop name(Caps sensitive)"
read event

evnt_name_underscore=`python3 Core\ Data/underscore.py $event`


sudo cp "Background/$event.png" "${data_git_repo_name}/$evnt_name_underscore/Participation/bg.png"


sudo cp "Core Data/logo.png" "${data_git_repo_name}/$evnt_name_underscore/Participation/"


sudo cp "Templates/$event.jpg" "${data_git_repo_name}/$evnt_name_underscore"

sudo cp "CSV Files/$event.csv" "${data_git_repo_name}/$evnt_name_underscore"

sudo cp "Core Data/STIXTwoText-Regular.otf" "${data_git_repo_name}/$evnt_name_underscore"
sudo cp "Core Data/IMFellEnglishSC-Regular.otf" "${data_git_repo_name}/$evnt_name_underscore"

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
cd ${data_git_repo_name}/$evnt_name_underscore
sudo find Participation -type f -not -name "*.png" -delete
sudo rm -r Participation/all_certificates/*
sudo python3 main_workshop.py $event $send $category $year
sudo cp "$event.csv" "../../CSV Files/"
sudo mkdir ~/$web_git_repo_name/${category}/$year/${evnt_name_underscore}
sudo rm -r ~/$web_git_repo_name/${category}/$year/${evnt_name_underscore}/*
sudo cp -R "Participation"/ ~/$web_git_repo_name/${category}/$year/${evnt_name_underscore}

cd ../
git pull
git add .
git commit -m "updated the event ${event}"
git push

cd ~/$web_git_repo_name/$category/
git pull
git add .
echo "add done"
git commit -m "updated the event ${event}"
echo "commit done"
git push
echo "push done"