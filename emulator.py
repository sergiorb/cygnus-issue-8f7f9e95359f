import requests
import logging
import json
import sys
import time
import random
from datetime import datetime, timedelta
import csv

API_KEY = sys.argv[1]
idashost = sys.argv[2]
ul20port = sys.argv[3]
deviceID = sys.argv[4]
timestamp = sys.argv[5]
startValue = int(sys.argv[6])
minValue = int(sys.argv[7])
maxValue = int(sys.argv[8])
direction = "up"

logger = logging.getLogger()
logger.setLevel(logging.INFO)
handler = logging.FileHandler(f'{deviceID}.{timestamp}.log', 'w', 'utf-8')
handler.setFormatter(logging.Formatter('%(name)s %(message)s'))
logger.addHandler(handler)

def sendData(deviceID, query, API_Key=API_KEY):

  URL = "http://"+idashost+":"+ul20port+'/iot/d?k='+API_Key+'&i='+deviceID
  HEADERS = {'content-type': 'text/plain'}

  logger.info(f'URL: {URL}')

  try:

    r = requests.post(URL, data=query, headers=HEADERS)

    logger.info(f'deviceID({deviceID}): Status Code: {str(r.status_code)}')

  except Exception as e:

    logger.info(f'post error({deviceID}): {e}')

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

    logger.info(f'({str(now)}) ---------------------------------------------------------------')

    startValue, direction = generateValue(startValue, direction, minValue, maxValue)

    logger.info(f'value: {startValue}')

    stationData = f'h|{startValue}|c|{startValue}|t|{startValue}'
                  
    sendData(deviceID, stationData)

  time.sleep(1)
