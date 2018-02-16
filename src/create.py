import requests
import RPi.GPIO as GPIO
import MFRC522
import picamera
import picamera.array
import numpy as np
import zbar

import atexit

def exit():
    GPIO.cleanup()

atexit.register(exit)

pcbid = "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF"

def create():
    r = requests.post("https://www.infected.no/api/rest/nfc/user/create.php", data ={'pcbId':pcbid, 'userId':scanQR(), 'cardId':scannCard()})
    return r.json()

def fill16(imp):
    out = imp
    while len(out) < 16:
        out +="0"
    return out

def scannCard():
    # Create an object of the class MFRC522
    MIFAREReader = MFRC522.MFRC522()

    while True:
        # Get the UID of the card
        (status,tagtype) = MIFAREReader.MFRC522_Request(MIFAREReader.PICC_REQIDL)
        (status,uid) = MIFAREReader.MFRC522_Anticoll()

        # If we have the UID, continue
        if status == MIFAREReader.MI_OK:
            uidhex = ""
            for i in uid:
                uidhex += hex(i)[2:]
            return(fill16(uidhex))

def scanQR():
    with picamera.PiCamera() as camera:
        camera.resolution = (1280, 720)
        camera.framerate = 24
        camera.start_preview()
        # Wait for the user to press Enter before capturing something

        while True:
            with picamera.array.PiYUVArray(camera) as stream:
                camera.capture(stream, format='yuv', use_video_port=True)
                #Now stream.array is a numpy array containing YUV image data.
                # zbar's Image class wants stuff in "Y800" format which just
                # means the Y plane (0) of this data.
                image = zbar.Image(1280, 720, 'Y800', stream.array[..., 0].tostring())
                # Finally, get zbar to scan it...
                scanner = zbar.ImageScanner()
                scanner.parse_config('enable')
                scanner.scan(image)
                for symbol in image:
                    return(int(symbol.data.replace("infected-user:", "")))

print(create())
