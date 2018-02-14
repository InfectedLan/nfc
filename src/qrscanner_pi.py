import io
import zbar
import picamera

scanner = zbar.Scanner()
scanner.parse_config('enable')
with picamera.PiCamera() as camera:
    stream = io.BytesIO()
    camera.start_preview()
    for foo in camera.capture_continuous(stream, format='jpeg'):
    # YOURS:  for frame in camera.capture_continuous(stream, format="bgr",  use_video_port=True):
        # Truncate the stream to the current position (in case
        # prior iterations output a longer image)
        stream.truncate()
        stream.seek(0)

        #scan = scanner.scan(gray)
        #if scan:
        #    print(scan)

# Release everything if job is finished
camera.stop_preview()
