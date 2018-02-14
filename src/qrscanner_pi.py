import zbar
import picamera

scanner = zbar.Scanner()
with picamera.PiCamera() as camera:
    stream = io.BytesIO()
    for foo in camera.capture_continuous(stream, format='jpeg'):
    # YOURS:  for frame in camera.capture_continuous(stream, format="bgr",  use_video_port=True):
        # Truncate the stream to the current position (in case
        # prior iterations output a longer image)
        stream.truncate()
        stream.seek(0)
        if process(stream):
            break

        scan = scanner.scan(gray)
        if scan:
            print(scan)

# Release everything if job is finished
cv2.destroyAllWindows()
