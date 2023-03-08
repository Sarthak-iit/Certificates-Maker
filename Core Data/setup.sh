#! /bin/sh

cd ../

#change to main directory
mkdir "CSV Files"
mkdir "Templates"
mkdir "Background"
cd Core\ Data 
web_git_repo_link=`python3 variables.py web_git_repo_link`
web_git_repo_name=`python3 variables.py web_git_repo_name`
data_git_repo_link=`python3 variables.py data_git_repo_link`
data_git_repo_name=`python3 variables.py data_git_repo_name`
year=`python3 variables.py year`
cd ../

git clone $data_git_repo_link

cd ~/

git clone $web_git_repo_link
mkdir $web_git_repo_name/Informal_Events/$year
mkdir $web_git_repo_name/Technical_Events/$year
mkdir $web_git_repo_name/Cultural_Events/$year
mkdir $web_git_repo_name/Workshops/$Year

