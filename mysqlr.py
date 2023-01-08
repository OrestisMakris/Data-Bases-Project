import mysql.connector
import random
import csv
from io import StringIO
nam =[]
last =[]
with open('C:\\Users\\Orestis\\Downloads\\names.txt', 'r' ,encoding= 'utf-16') as names:                                                                                        
 for line in names:
        row =line.split()
        nam.append(row[:-1])
        last.append(row[-1])



mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  password="",
  database="travel_agency"
)

mycursor = mydb.cursor()

for i in range(1,65000,1):
 index = random.randint(0, 9999)
 Name = nam[index][0]
 lastname = last[index]
 amount = random.randint(70, 200)
 id = random.randint(1, 3)
 sql = "INSERT INTO reservation_offers (rsv_name, rsv_lastname , deposit_amount , rsv_offer_id) VALUES (%s, %s ,%s, %s)"
 val = ( Name,lastname ,amount ,id)
 mycursor.execute(sql, val)
 mydb.commit()
print(mycursor.rowcount, "record inserted.")