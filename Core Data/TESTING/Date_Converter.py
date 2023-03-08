import datetime

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
    if (not math.isnan(b)) :
        date_from=a.split('/')
        date_to=b.split('/')
        date_from = datetime.datetime(int(date_from[2])+2000,int(date_from[1]),int(date_from[0]))
        date_to = datetime.datetime(int(date_to[2])+2000,int(date_to[1]),int(date_to[0]))
        string = 'from ' + day_to_suffix(date_from.strftime("%d")) + ' ' + date_from.strftime("%B") + ' ' + date_from.strftime("%Y") + ' to '+ day_to_suffix(date_to.strftime("%d")) + ' ' + date_to.strftime("%B")+' '+date_to.strftime("%Y")
    else:
        date=a.split('/')
        date = datetime.datetime(int(date[2])+2000,int(date[1]),int(date[0]))
        string = 'on' + ' '+ day_to_suffix(date.strftime("%d")) + ' ' + date.strftime("%B") + ' ' + date.strftime("%Y")
    return string
        

