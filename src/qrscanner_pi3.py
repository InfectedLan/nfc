import picamera
import picamera.array
import numpy as np
import zbar

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
                print(symbol.type, symbol.data)

