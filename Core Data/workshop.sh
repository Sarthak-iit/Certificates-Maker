#!/bin/sh
#only for workshops

data_git_repo_name=`python3 variables.py data_git_repo_name`
web_git_repo_name=`python3 variables.py web_git_repo_name`
web_git_repo_link=`python3 variables.py web_git_repo_link`
year=`python3 variables.py year`

category="Workshops"
cd ../
#change to main directory
main_dir= `pwd`

if test -d $web_git_repo_name
then
	if test -d $web_git_repo_name/Workshops/$year
	then
		echo "Website directories exist"
	else
		mkdir $web_git_repo_name/Workshops/$year
	fi
else
	git clone $web_git_repo_link
	if test -d $web_git_repo_name/Workshops/$year
	then
		echo "Website directories exist"
	else
		mkdir $web_git_repo_name/Workshops/$year
	fi
	echo "Website directories created"
fi


echo "Enter workshop name(Caps sensitive)"
read event

evnt_name_underscore=`python3 Core\ Data/underscore.py $event`

sudo mkdir ${data_git_repo_name}/$evnt_name_underscore
sudo mkdir ${data_git_repo_name}/$evnt_name_underscore
sudo mkdir ${data_git_repo_name}/$evnt_name_underscore/Participation
sudo mkdir ${data_git_repo_name}/$evnt_name_underscore/Participation/all_certificates

sudo cp "Core Data/main_workshop.py" "${data_git_repo_name}/$evnt_name_underscore"
sudo cp "Core Data/Date_Converter.py" "${data_git_repo_name}/$evnt_name_underscore"

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
sudo python3 main_workshop.py $event $send $category $year
echo ${category}
mkdir ${main_dir}/$web_git_repo_name/${category}/$year/${evnt_name_underscore}
sudo cp -R "Participation"/ ${main_dir}/$web_git_repo_name/${category}/$year/${evnt_name_underscore}

cd ../
git pull
git add .
git commit -m "added the event ${event}"
git push

cd ${main_dir}/$web_git_repo_name/$category/
git pull
git add .
echo "add done"
git commit -m "added the event ${event}"
echo "commit done"
git push
echo "push done"