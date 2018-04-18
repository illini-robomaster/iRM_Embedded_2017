#!/usr/bin/env python
import serial
import sys
import os
import time
import sys

data_dir = "data_history/"
if not os.path.exists(data_dir):
    os.makedirs(data_dir)

device_loc = '/dev/cu.SLAB_USBtoUART'
save_path = data_dir + time.ctime() + '.txt'
connected = False

try:
    print "Trying to connect to " + device_loc
    ser = serial.Serial(device_loc, 115200)
except serial.serialutil.SerialException:
    print "Fatal error: Device not found"
    sys.exit(-1)

save_stream = open(save_path, "wb")

while not connected:
    data = ser.read() #blocking
    connected = True

try:
    while True:
        if ser.inWaiting():
            data = ser.read()
            sys.stdout.write(data)
            sys.stdout.flush()
            save_stream.write(data)
except KeyboardInterrupt:
    print "Cleaning up..."
    save_stream.close()
    ser.close()
