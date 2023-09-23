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

mkdir ${data_git_repo_name}/$evnt_name_underscore
mkdir ${data_git_repo_name}/$evnt_name_underscore
mkdir ${data_git_repo_name}/$evnt_name_underscore/Participation
mkdir ${data_git_repo_name}/$evnt_name_underscore/Participation/all_certificates

cp "Core Data/main_workshop.py" "${data_git_repo_name}/$evnt_name_underscore"
cp "Core Data/Date_Converter.py" "${data_git_repo_name}/$evnt_name_underscore"

cp "Background/$event.png" "${data_git_repo_name}/$evnt_name_underscore/Participation/bg.png"


cp "Core Data/logo.png" "${data_git_repo_name}/$evnt_name_underscore/Participation/"


cp "Templates/$event.jpg" "${data_git_repo_name}/$evnt_name_underscore"

cp "CSV Files/$event.csv" "${data_git_repo_name}/$evnt_name_underscore"

cp "Core Data/STIXTwoText-Regular.otf" "${data_git_repo_name}/$evnt_name_underscore"
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
cd ${data_git_repo_name}/$evnt_name_underscore
python3 main_workshop.py $event $send $category $year
echo ${category}
mkdir ~/$web_git_repo_name/${category}/$year/${evnt_name_underscore}
cp -R "Participation" ~/$web_git_repo_name/${category}/$year/${evnt_name_underscore}

cd ../../
git pull
git add .
git commit -m "added the event ${event}"
git push

cd ~/$web_git_repo_name/$category/
git pull
git add .
echo "add done"
git commit -m "added the event ${event}"
echo "commit done"
git push
echo "push done"