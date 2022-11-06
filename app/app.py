from typing import List, Dict
from flask import Flask, render_template, json, jsonify
from pandas import DataFrame
import time
import os
import mysql.connector
import json
import csv
import pandas as pd
import sftp
import createattendance
import numpy as np
from dotenv import load_dotenv
load_dotenv()


app = Flask(__name__)

def read_csv():
	csv_file = 'attendance.csv'
	global empdata
	empdata = pd.read_csv(csv_file, encoding='utf8',delimiter = ',')
	empdata = empdata.where((pd.notnull(empdata)), None)
	empdata.fillna(0,inplace=True)
	empdata.head()

	
def student_data() -> List[Dict]:
    connection =mysql.connector.connect(host=os.environ.get('DB_HOST'),username=os.environ.get('DB_UNAME'),password=os.environ.get('DB_PASSWORD'),database='devopsroles')
    cursor = connection.cursor()
    cursor.execute('SELECT * FROM student_data')
    results = cursor.fetchall()
    cursor.close()
    connection.close()
    return results

def createdatabase():
    connection = mysql.connector.connect(host=os.environ.get('DB_HOST'),username=os.environ.get('DB_UNAME'),password=os.environ.get('DB_PASSWORD'))
    cursor = connection.cursor()
    cursor.execute("CREATE DATABASE  IF NOT EXISTS  devopsroles")
    connection.commit()
    cursor.close()
    connection.close()
    connection =mysql.connector.connect(host=os.environ.get('DB_HOST'),username=os.environ.get('DB_UNAME'),password=os.environ.get('DB_PASSWORD'),database='devopsroles')
    cursor = connection.cursor()
    cursor.execute("CREATE TABLE IF NOT EXISTS student_data(names VARCHAR(255),names2 VARCHAR(255),dates1 VARCHAR(30),dates2 VARCHAR(30),dates3 VARCHAR(30),dates4 VARCHAR(30),dates5 VARCHAR(30),dates6 VARCHAR(30),dates7 VARCHAR(30),dates8 VARCHAR(30),dates9 VARCHAR(30),dates10 VARCHAR(30),dates11 VARCHAR(30),dates12 VARCHAR(30),dates13 VARCHAR(30),dates14 VARCHAR(30),sum VARCHAR(25)) DEFAULT CHARSET=utf8") 

    for i,row in empdata.iterrows():
            #here %S means string values 
            sql = "INSERT INTO devopsroles.student_data VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s )"
            empdata.fillna(0)
            #print(sql, tuple(row))
            cursor.execute(sql, tuple(row))
            connection.commit()
    cursor.close()
    connection.close()    

@app.route('/')
def index() -> str:
    return render_template("home.html")
    #return json.dumps({'student_data': student_data()})

@app.route('/attendance')
def home():
    #return render_template("front.html", students=json.dumps({'student_data': student_data()}))
    
    with open("attendance.csv", encoding="utf8") as file:
         return render_template("csv_ui.html", csv=file)

if __name__ == '__main__':
    sftp.download_csvs()
    createattendance.main()
    
    read_csv()
    #creates error on start, the app.py file runs faster then the db and he crashes, adds waiting time.
    time.sleep(10)
    createdatabase()
    app.run(host='0.0.0.0',port=5000)
    
