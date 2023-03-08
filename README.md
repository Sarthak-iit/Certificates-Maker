
# Certificate Maker

## Setup

1) Add yourself as a collaborator in the certificates git repo
1) Create an ssh id and add it into your github account ([Refer](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)). You might have to generate a new ssh key.
3) Open data.txt and add the ssh id of the website github repo  and the certificates data github repo and the year you are working in.
4) Open terminal in Mac/Linux or Command Prompt in Windows and changing the working directory to the folder 'Core Data' inside the main folder('WORKFLOW') by using cd.
5) Run the Setup.sh script file by type the following command on your terminal 
```
bash setup.sh
```
## Creating Certificates
### Pre-Processing Data for Certificates
#### Preparing the CSV Files
1. Refer to the test.csv file for how data should look like
2. There should be two csv files with the names `[event_name].csv` and `[event_name]_win.csv` for the details of participants and winners respectively. Both should have the following informtion.
3. The csv files should be saved in the folder `CSV Files`.
2. It should contain both name and email of each participant. IF THE EMAIL OF MORE THAN ONE PARTICIPANT IS SAME THEN MAKE SURE THEIR NAME ARE DIFFERENT. ALSO ENSURE THAT EMAIL ID'S GIVEN ARE CORRECT.
3. It should have two columns named 'event', 'desc' with them containing name of event and their description respectively. For example: Algo-Quest and Competitive Programming. THE DESC SHOULD NOT CONTAIN COMPETITION, IT WILL BE APPENDED AUTOMATICALLY.
4. It should have two columns called 'from' and 'to' that contain start and end date of the competition. For competitions held on a single day write the date in the from column and leave the to column blank.
5. It should also contain two columns(name_x,name_y) with the coordinates of the center of the name bar based on the certificate template of the given event. The x coordinate should be at the center of the line under the name. The y coordinate should be just above the line under the name.
6. It should also contain two columns(qr_x,qr_y) with the coordinates of the center of the qr code to be add based on the certificate template of the given event. The size of the qr code is 288x288 pixels on a 2000x1414 size certificate.
9. To get the coordinates for the csv file use [PixSpy](https://pixspy.com/).
7. For the winners sheet it should contain a column called pos with the position of the winners in numerical format i.e 1,2,3,..
8. ENSURE CASE SENSITIVITY WHEN WORKING WITH THE CSV FILE.

#### Preparing the Certificate Templates
1. There needs to be 1 template for participation and upto 6 templates for winner certificates.
2. The participation certificate should be named `[event_name].jpg` and saved inside the `Templates` Folder.
3. There can be a maximum of 6 winner certificates with the first 5 for positions 1-5 and 6th for position 6-20. The winner certificate templates should be saved with the name `[event_name]-[position].jpg` where position can be from 1-6 for the different certificates. These templates to be also saved inside the `Templates` Folder.
4. To get the coordinates for the csv file use [PixSpy](https://pixspy.com/).
5. ALL TEMPLATES TO BE IN .JPG FORMAT.

### Preparing the Certificates

1. Change the current working directory to `Core Data` by using the following command 
`cd ~/[location of download]/WORKFLOW/Core\ Data` 
2. Run the certi.sh sheel script using `bash certi.sh`.
3. In the first prompt enter the name of the event. Make sure to use the same name used for the csv and templates. THE NAME IS CASE SENSITIVE.
4. In the second prompt choose the type of event from Technical,  Cultural, Informal, Workshops. THE OPTIONS ARE CASE SENSITIVE.
5. There will be error regarding missing templates depending on how many are there. The script looks for 6 templates if you only need to use 3 ignore the errors.
6. Next the program will ask if you want to send emails. Enter 'Yes I want to send the emails' if you want to send. The emails will be sent through events.petrichor@iitpkd.ac.in by default. THIS ACTION IS IRREVERSIBLE, PLEASE CONFIRM THAT ALL DATA ESPECIALLY THE CSV FILE IS CORRECT. IF ANY EMAIL IS WRONG IT WILL GIVE AN ERROR AND STOP THE PROGRAM.
7. It will show a loading bar for the emails. Wait for it to complete. It may take a few minutes especially if the number of mails to be sent is long.

