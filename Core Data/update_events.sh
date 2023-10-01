#! /bin/sh
#!/bin/sh

#only for events
data_git_repo_name=`python3 variables.py data_git_repo_name`
web_git_repo_name=`python3 variables.py web_git_repo_name`
year=`python3 variables.py year`

echo ${category}
cd ../
#change to main directory
main_dir= `pwd`


echo "Enter event name(Caps sensitive)"
read event



category=${category}_Events
evnt_name_underscore=`python3 Core\ Data/underscore.py $event`


cp "Background/$event.png" "${data_git_repo_name}/$evnt_name_underscore/Participation_data/Participation/bg.png"
cp "Background/$event.png" "${data_git_repo_name}/$evnt_name_underscore/Winner_data/Winner/bg.png"

cp "Core Data/logo.png" "${data_git_repo_name}/$evnt_name_underscore/Participation_data/Participation/"
cp "Core Data/logo.png" "${data_git_repo_name}/$evnt_name_underscore/Winner_data/Winner/"

cp "Templates/$event.jpg" "${data_git_repo_name}/$evnt_name_underscore/Participation_data"
cp "Templates/$event-1.jpg" "${data_git_repo_name}/$evnt_name_underscore/Winner_data"

cp "Templates/$event-2.jpg" "${data_git_repo_name}/$evnt_name_underscore/Winner_data"
cp "Templates/$event-3.jpg" "${data_git_repo_name}/$evnt_name_underscore/Winner_data"
cp "Templates/$event-4.jpg" "${data_git_repo_name}/$evnt_name_underscore/Winner_data"
cp "Templates/$event-5.jpg" "${data_git_repo_name}/$evnt_name_underscore/Winner_data"
cp "Templates/$event-6.jpg" "${data_git_repo_name}/$evnt_name_underscore/Winner_data"
cp "Core Data/STIXTwoText-Regular.otf" "${data_git_repo_name}/$evnt_name_underscore/Participation_data"
cp "Core Data/STIXTwoText-Regular.otf" "${data_git_repo_name}/$evnt_name_underscore/Winner_data"
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
if [ $email == "YES" ] || [ $email == "YES I WANT TO SEND EMAILS" ]
then 
	send=1
fi
cd ${data_git_repo_name}/$evnt_name_underscore/Participation_data
find Participation -type f -not -name "*.png" -delete
rm -r Participation/all_certificates/*
python3 main_new.py $event $send $category $year
mkdir ~/$web_git_repo_name/${category}/$year/${evnt_name_underscore}
rm -r ~/$web_git_repo_name/${category}/$year/${evnt_name_underscore}/*
cp -R "Participation" ~/$web_git_repo_name/${category}/$year/${evnt_name_underscore}
cd "../Winner_data"
find Winner -type f -not -name "*.png" -delete
rm -r Winner/all_certificates/*
python3 winner_new.py $event $send $category $year
cp -R "Winner" ~/$web_git_repo_name/${category}/$year/${evnt_name_underscore}

cd ../../
git pull
git add .
git commit -m "updated the event ${event}"
git push

cd ~/$web_git_repo_name/$category/
git pull
git add .
git commit -m "updated the event ${event}"
git push