import zbar
import picamera

#Number is cameranumber
camera = picamera.PiCamera()
scanner = zbar.Scanner()
camera.start_preview()

#while True:
    #ret, output = cap.read()
    #gray = cv2.cvtColor(output, cv2.COLOR_BGR2GRAY, dstCn=0)
    #cv2.imshow('output', output)
    #scan = scanner.scan(gray)
    #if scan:
        #print(scan)
    #if cv2.waitKey(1) & 0xFF == ord('q'):
        #break

# Release everything if job is finished
#cap.release()
#cv2.destroyAllWindows()
