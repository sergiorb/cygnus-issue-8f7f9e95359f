import requests
import json
import sys
import time
import random
from datetime import datetime, timedelta
import csv
from pyowm import OWM

API_KEY = sys.argv[1]
idashost = sys.argv[2]
ul20port = sys.argv[3]
deviceID = sys.argv[4]
lastValue = 100
direction = "up"

def sendData(deviceID, query, API_Key=API_KEY):

  URL = "http://"+idashost+":"+ul20port+'/iot/d?k='+API_Key+'&i='+deviceID
  HEADERS = {'content-type': 'text/plain'}

  print("URL: ", URL)

  try:
    r = requests.post(URL, data=query, headers=HEADERS)

    print(deviceID, "* Status Code: "+str(r.status_code))

  except Exception as e:
    print('post error', e)

def generateValue(holder, direction, mini, maxi):

  if holder > maxi:
    direction = "down"

  if holder < mini:
    direction = "up"

  if direction == "up":
    holder = holder + 15
  else:
    holder = holder - 15
  
  return holder, direction

while True:

  now = datetime.now()

  if (now.second == 0):

    lastValue, direction = generateValue(lastValue, direction, 50, 150)

    print("value: ", lastValue)

    stationData = f'h|{lastValue}|c|{lastValue}|t|{lastValue}'
                  
    sendData(deviceID, stationData)

  time.sleep(1)
