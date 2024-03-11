from PIL import Image,ImageDraw,ImageFont
import pandas as pd
import qrcode
import yagmail
import os
import sys
import Date_Converter
from timeit import default_timer as timer
import math
import pdb
import datetime
import threading
import time
from tqdm import tqdm

def send_mail(item,year,index):
    name_wo_spc = item['name'].replace(' ','')
    global current_mail_no
    global dataframe
    

    if item['sent']!='YES':
        email=item['email']
        contents = [f'''Dear Participant, 

                    Thanks for participating in the event {item['event']} by Petrichor'{year[-2:]} . This is the attached participation certificate.

                    We would also like you to fill this <a href="https://docs.google.com/forms/d/e/1FAIpQLSeOYaaaoRvcJopcLrSEMHGAE6v9P7M57PQL8t24Apzi3w_Ysw/viewform">feedback form</a> so that we can take your suggestions and improve next year.
                    
                    If any concerns please reply to this mail


            Regards,
            Petrichor Technical Team.
            ''', f'./Participation/all_certificates/{name_wo_spc}-{email}.jpg'
        ]
        yag.send(f'{email}', f"Petrichor'{year[-2:]}: {item['event']} Participation Certificate", contents)
        dataframe.loc[index,'sent']='YES'
    current_mail_no+=1

def day_to_suffix(day):
    day=int(day)
    if day==1:
        return '1st'
    elif day==2:
        return '2nd'
    elif day==3:
        return '3rd'
    else:
        return str(day)+'th'

def date_to_text(a,b):
    if (type(b)==str) :
        if ('/' in a):
            date_from=a.split('/')
            date_to=b.split('/')
        elif ('-' in b):
            date_from=a.split('-')
            date_to=b.split('-')
        if int(date_from[2])<100:
            date_from = datetime.datetime(int(date_from[2])+2000,int(date_from[1]),int(date_from[0]))
        else:
            date_from = datetime.datetime(int(date_from[2]),int(date_from[1]),int(date_from[0]))
        if int(date_to[2])<100:
            date_to = datetime.datetime(int(date_to[2])+2000,int(date_to[1]),int(date_to[0]))
        else:
            date_to = datetime.datetime(int(date_to[2]),int(date_to[1]),int(date_to[0]))
        if date_to-date_from == datetime.timedelta(days=1):
            string = 'on ' + day_to_suffix(date_from.strftime("%d"))+ ', '+ day_to_suffix(date_to.strftime("%d")) + ' ' + date_to.strftime("%B")+' '+date_to.strftime("%Y")
        else:
            string = 'from ' + day_to_suffix(date_from.strftime("%d")) + ' ' + date_from.strftime("%B") + ' ' + date_from.strftime("%Y") + ' to '+ day_to_suffix(date_to.strftime("%d")) + ' ' + date_to.strftime("%B")+' '+date_to.strftime("%Y")
    else:
        date=a.split('/')
        if int(date[2])<100:
            date = datetime.datetime(int(date[2])+2000,int(date[1]),int(date[0]))
        else:
            date = datetime.datetime(int(date[2]),int(date[1]),int(date[0]))
        string = 'on' + ' '+ day_to_suffix(date.strftime("%d")) + ' ' + date.strftime("%B") + ' ' + date.strftime("%Y")
    return string

def time_left(start_time,current_iter,total_iter):
    current_time = timer()
    per_iter_time = (current_time - start_time)/(current_iter if current_iter else 1)
    iter_left = total_iter - current_iter
    time_left = iter_left * per_iter_time
    return time_left
    


def print_percentage(start_time,current_iter,total_iter):
    global current_mail_no
    global sent
    os.system('clear')
    current_perc = math.ceil((current_iter*100)/total_iter)
    k=math.ceil(current_perc*40/100)
    t_left = math.floor(time_left(start_time,current_iter,total_iter))
    while (t_left >= 0):
        if current_iter==current_mail_no:
            os.system('clear')
            print(current_iter,total_iter,)
            print('['+('|'* k) + (' '*(40-k)) + '] '+ str(current_perc) + '%' + 'Time Left : ' + str(t_left) + 'secs',sep='')
            time.sleep(0.99)
            t_left -= 1
        else:
            break


input_data=sys.argv #data from command line in the format filename, event_name, email send or not, category, year

eventname=''

for i in range(1,len(input_data)-3):
    eventname+=f'{input_data[i]} '
eventname=eventname.rstrip()

path=f"./{eventname}.csv"
year=input_data[-1]
send= int(input_data[-3])
global dataframe
dataframe=pd.read_csv(path)
font_name=ImageFont.truetype('./STIXTwoText-Regular.otf',80,encoding="unic")
font_event=ImageFont.truetype('./STIXTwoText-Regular.otf',50,encoding="unic")
event_category = input_data[-2]
directory_cert="./Participation/all_certificates"
directory="./Participation"



for index,item in dataframe.iterrows():
    
    img=Image.open(f'{item["event"]}.jpg')

    
    
    draw=ImageDraw.Draw(img)
    qr = qrcode.QRCode(
    version=1,
    error_correction=qrcode.constants.ERROR_CORRECT_L,
    box_size=7,
    border=2
    )
    name_wo_spc = item['name'].replace(' ','')
    event_with_under = item['event'].replace(' ','_')
    qr_path=''
    if event_category == 'Workshops':
        qr_path = f"https://www.cert.petrichor.events/Workshops/{year}/{name_wo_spc}-{item['email']}.html"
    else:
        qr_path = f"https://www.cert.petrichor.events/{event_category}/{year}/{event_with_under}/Participation/{name_wo_spc}-{item['email']}.html"
    qr.add_data(f'{qr_path}')
    qr.make()
    qr_img = qr.make_image(fill_color="black", back_color=(228,212,255))




    W, H = (int(item['name_x']),int(item['name_y']))
#    W, H = (786,750)
    msg = f"{item['name']}"
    _, _, w, h = draw.textbbox((0, 0), msg, font=font_event)
    draw.text((W-w/2,H-h/2),text=f"{item['name']}",fill=(0,0,0),font=font_event)


    
   # draw.text(xy=(1050,746),text=f"{item['name']}",fill=(255,255,255),font=font_event)
        
#    offset=1123,1073
    size = int(qr_img.size[0]/2)
    offset = (int(item['qr_x'])-size),(int(item['qr_y'])-size)
    img.paste(qr_img,offset)
    img.save('{}/{}-{}.jpg'.format(directory_cert,name_wo_spc,item['email']))

    date_string = date_to_text(item['from'],item['to'])


    f = open(f"{directory}/{name_wo_spc}-{item['email']}.html",'w')
    message = f"""<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Petrichor</title>
    <style>
        body
        {{
            background-image: url("./bg.png");
            background-repeat: no-repeat;
            background-size: cover;
            padding: 0;
            margin: 0;
            min-height: 100vh;
        }}
        #heading
        {{
            display: flex;
            padding-left: 37vw;
            align-self: flex-start;
           
        }}
        h1
        {{
            color: whitesmoke;
            font-size: 50px;
            letter-spacing: 4px;
            font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif; 
            text-align: center;
            
             
        }}
        #logo
        {{
            
            width: 50px;
            display: flex;
            justify-self: left;
            align-self: top;
            padding-left: 30px;
            margin-top: -95px;
            padding-bottom: 15px;
        }}#cer
        {{
            width: 21vw;
            outline: 1px solid whitesmoke;
            display: flex;
            align-self: center;
            margin: 20px;
            padding: 5px;
        }}
        #content
        {{
            display: flex;
            justify-content: center;
            justify-self: center;
            align-self: center;
            margin-left:10vw;
            width: 80vw;
            height: auto;
            outline: 1px solid whitesmoke;
            
        
            
        }}
        p
        {{
            color: whitesmoke;
            font-size: 30px;
            letter-spacing: 3px;
            word-spacing: 7px;
            font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif; 
            padding-left: 5vw;
            display: flex;
            align-self: center;
            z-index: 5;
        }}
        @media screen and (max-width:950px)
        {{
            #heading
            {{
                padding-left: 32vw;

            }}
           
            #cer
            {{
                width: 27vw;
            }}      
        }}
        @media screen and (max-width:770px)
        {{
            #heading
            {{
                padding-left: 27vw;

            }}
            
            #content
            {{
                display: grid;
                justify-items: center;  
                margin-bottom: 10vh;         
            }}
            #cer
            {{
                width: 70vw;
            }}
                          
        }}
        @media screen and (max-width:500px)
        {{
            #heading
            {{
                padding-left: 20vw;

            }}
            h1 
            {{
                font-size: 30px;
            }}
            #content
            {{
                width: 96vw;
                margin-left: 2vw;
            }}   
            
            p
            {{
                font-size: 20px;
                letter-spacing: 1px;
                word-spacing: 3px;

            }}
            #logo
            {{
                width: 40px;
                padding-left: 15px;
                margin-top: -80px;
                padding-top: 20px;
                padding-bottom: 10px;
            }}  
        }}
        @media screen and (max-width:290px)
        {{
            #heading
            {{
                padding-left: 10vw;
                font-size: 40px;

            }}
            #logo
            {{
                opacity: 0;
            }}  
        }}
        
    </style>
</head>
<body>
    <div id="heading">
        <h1>Petrichor '{year[-2:]}</h1>
    </div>
    <div id="im">
        <img src="logo.png" alt="" id="logo" >
    </div>
        
    <div id="content">
        <p>This certificate is awarded to {item['name']} for participating in the event {item['event']}, the {item['desc']} Competition conducted by Petrichor, IIT Palakkad {date_string}.</p>
        <a href="./all_certificates/{name_wo_spc}-{item['email']}.jpg" target="_blank"><img src="./all_certificates/{name_wo_spc}-{item['email']}.jpg" alt="" id="cer"></a>
    </div>
        
</body>
</html>"""

    f.write(message)
    f.close()

start = timer()
current_mail_no=0
total_mail_no=len(dataframe.index)
if send==1:
        yag = yagmail.SMTP('events.petrichor@iitpkd.ac.in', 'esbfbqaippqvlmfd')
        for index in tqdm(range(len(dataframe)), desc = 'Email'):
            send_mail(dict(dataframe.loc[index]),year,index)
##        for filename in os.listdir(directory_cert):
##          for index,item in dataframe.iterrows():
##                process1 = threading.Thread(target=send_mail, args = (item,year,index))
##                process2 = threading.Thread(target=print_percentage, args = (start,current_mail_no,total_mail_no,))
##                process1.start()
##                process2.start()
##                process1.join()
dataframe.to_csv(path,index=False)

# another method of sending the mail


# for filename in os.listdir(directory):
#     for index,item in dataframe.iterrows():
#         if f"{item['email']}.jpg"==filename:
#             email=item['email']
#     server = smtplib.SMTP('smtp.gmail.com', 587)
#     server.starttls()
#     server.login(email_sender,password)
#     msg = MIMEMultipart()
#     msg['From'] = email_sender
#     msg['To'] =email
#     msg['Subject'] = "Technology and Entrepreneurship Summit Certificate"

#     body = '''Dear Participant, 

#     Thanks for participating in the Technology and Entrepreneurship Summit. Please find the attached certificate. 

#     Regards,
#     Petrichor Technical Team.
#     '''

#     msg.attach(MIMEText(body, 'plain'))
#     file=f"{os.path.join(directory, filename)}"
#     attachment = open(file, "rb")
#     p = MIMEBase('application', 'octet-stream')
#     p.set_payload((attachment).read())
#     encoders.encode_base64(p)
#     p.add_header('Content-Disposition', "attachment; filename= %s" % email)
#     msg.attach(p)
    

#     text = msg.as_string()
#     server.send_message(msg)
#     server.quit()




