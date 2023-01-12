import mysql.connector
import random
import csv
from io import StringIO
import sys
nam =[]
last =[]
with open('C:\\Users\\Orestis\\Downloads\\names.txt', 'r' ,encoding= 'utf-16') as names:                                                                                        
 for line in names:
        row =line.split()
        nam.append(row[:-1])
        last.append(row[-1])



# mydb = mysql.connector.connect(
#   host="localhost",
#   user="root", INSERT INTO reservation_offers VALUES
#   password="",
#   database="travel_agency"
# )

# mycursor = mydb.cursor()

with open('C:\\Users\\Orestis\OneDrive - University of Patras\\Documents\\GitHub\\Data-Bases-Project\\Insert_many_reservations.sql', 'w') as f:
 sys.stdout = f 
    

 for i in range(1,65000,1):
  index = random.randint(0, 9999)
  Name = nam[index][0]
  lastname = last[index]
  amount = random.randint(70, 200)
  id = random.randint(1, 3)
  print("(null ,'%(n)s','%(l)s',%(a)s,%(id)s)," % {'n':nam[index][0], 'l':last[index] ,'a':amount,'id':id})
#  sql = "INSERT INTO reservation_offers (rsv_name, rsv_lastname , deposit_amount , rsv_offer_id) VALUES (%s, %s ,%s, %s)"
#  val = ( Name,lastname ,amount ,id)
#  mycursor.execute(sql, val)
#  mydb.commit()
