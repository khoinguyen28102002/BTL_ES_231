import sys
from Adafruit_IO import MQTTClient
import time
import random
from gateway_pub import *

AIO_FEED_IDs = ["fan-status", "light-status"]
AIO_USERNAME = "khoinguyen3923"
AIO_KEY = "aio_VCgt28YXuFdFbSzntJcOV9seUb6P"

def connected(client):
    print("Ket noi thanh cong ...")
    #Button subcribe to feed on adafruit
    for topic in AIO_FEED_IDs:
        client.subscribe(topic)

# This function is called when sucessfully subcribe to feed on adafruit
def subscribe(client , userdata , mid , granted_qos):
    print("Subscribe thanh cong ...")

def disconnected(client):
    print("Ngat ket noi ...")
    sys.exit (1)

def WriteData(data):
    ser.write(str(data).encode())
    
# This function is called when gateway receive a signal from adafruit
def message(client , feed_id , payload):
    print("Nhan du lieu: " + payload, "feed_id: " + feed_id)
    if feed_id == "light-status":
        if payload == "0":
            WriteData(1) # Turn off the light
            print("led off")
        else:
            WriteData(2) # Turn on the light
            print("led on")
    elif feed_id == "fan-status":
        if payload == "0":
            WriteData(3) # Turn off the fan
            print("fan off")
        else:
            WriteData(4) # Turn on the fan
            print("fan on")

client = MQTTClient(AIO_USERNAME , AIO_KEY)
client.on_connect = connected
client.on_disconnect = disconnected
client.on_message = message
client.on_subscribe = subscribe
client.connect()
client.loop_background()

counter = 10
while True:
    counter = counter - 1
    if counter <= 0:
        counter = 10
    readSerial(client)
    time.sleep(1)
    pass