#! /bin/sh
#in Core data directory
data_git_repo_name=`python3 variables.py data_git_repo_name`
web_git_repo_name=`python3 variables.py web_git_repo_name`
year=`python3 variables.py year`

cd ../
#change to main directory
main_dir= `pwd`
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
echo "Enter event name(Caps sensitive)"
read event
echo "Enter which category is it?('Technical' , 'Cultural' , 'Informal' , 'Workshops')"
read category
while [ $category != "Technical" -a $category != "Cultural" -a $category != "Informal" -a $category != "Workshops" ]
do
	echo "Choose from 'Technical' , 'Cultural' , 'Informal' , 'Workshops'"
	read category
done


#only for events

category=${category}_Events
evnt_name_underscore=`python3 Core\ Data/underscore.py $event`

mkdir ${data_git_repo_name}/$evnt_name_underscore
mkdir ${data_git_repo_name}/$evnt_name_underscore/Participation_data
mkdir ${data_git_repo_name}/$evnt_name_underscore/Participation_data/Participation
mkdir ${data_git_repo_name}/$evnt_name_underscore/Participation_data/Participation/all_certificates
mkdir ${data_git_repo_name}/$evnt_name_underscore/Winner_data
mkdir ${data_git_repo_name}/$evnt_name_underscore/Winner_data/Winner
mkdir ${data_git_repo_name}/$evnt_name_underscore/Winner_data/Winner/all_certificates

cp "Core Data/main_new.py" "${data_git_repo_name}/$evnt_name_underscore/Participation_data"
cp "Core Data/Date_Converter.py" "${data_git_repo_name}/$evnt_name_underscore/Participation_data"
cp "Core Data/winner_new.py" "${data_git_repo_name}/$evnt_name_underscore/Winner_data"
cp "Core Data/Date_Converter.py" "${data_git_repo_name}/$evnt_name_underscore/Winner_data"

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
cp "CSV Files/$event.csv" "${data_git_repo_name}/$evnt_name_underscore/Participation_data"
cp "CSV Files/$event.csv" "${data_git_repo_name}/$evnt_name_underscore/Winner_data"
cp "Core Data/STIXTwoText-Regular.otf" "${data_git_repo_name}/$evnt_name_underscore/Participation_data"
cp "Core Data/STIXTwoText-Regular.otf" "${data_git_repo_name}/$evnt_name_underscore/Winner_data"
echo "Do you want to send email?(If yes enter 'YES',if no type 'N')"
read email
while [ $email != "YES" -a $email != "N" -a $email != "No" ]
do
	echo "Do you want to send email?(If yes enter 'YES I WANT TO SEND EMAILS',if no enter 'N')"
	read email
done
send=0
if [ $email == "YES" ]
then 
	send=1
fi
cd ${data_git_repo_name}/$evnt_name_underscore/Participation_data
python3 main_new.py $event $send $category
mkdir ~/$web_git_repo_name/${category}/$year/${evnt_name_underscore}
cp -R "Participation" ~/$web_git_repo_name/${category}/$year/${evnt_name_underscore}
cd "../Winner_data"
python3 winner_new.py $event $send $category
cp -R "Winner" ~/$web_git_repo_name/${category}/$year/${evnt_name_underscore}

cd ../../
git pull
git add .
git commit -m "added the event ${event}"
git push

cd ~/$web_git_repo_name/$category/
git pull
git add .
git commit -m "added the event ${event}"
git push







 
