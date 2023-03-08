echo "Do you want to send email?(If yes enter 'YES I WANT TO SEND EMAILS',if no type 'N')"
read email
while [ $email != "YES I WANT TO SEND EMAILS" -a $email != "N" -a $email != "No" ]
do
	echo "Do you want to send email?(If yes enter 'YES I WANT TO SEND EMAILS',if no enter 'N')"
	read email
done