import mysql.connector
import random
import csv
from io import StringIO
nam =[]
last =[]
with open('names.txt', 'r' ,encoding= 'utf-16') as names:                                                                                        
 for line in names:
        row =line.split()
        nam.append(row[:-1])
        last.append(row[-1])



mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  password="giagia12",
  database="travel_agency"
)

mycursor = mydb.cursor()

for j in range(0,6,1):
  for i in range(0,10000,1):
    index = i
    name = nam[index][0]
    lastname = last[index]
    amount = random.randint(70, 200)
    offer_id = random.randint(1, 3)
    sql = "INSERT INTO reservation_offers (rsv_name, rsv_lastname , deposit_amount , rsv_offer_id) VALUES (%s, %s ,%s, %s)"
    val = (name,lastname,amount,offer_id)
    mycursor.execute(sql, val)
    mydb.commit()
  print(mycursor.rowcount, "record inserted.")