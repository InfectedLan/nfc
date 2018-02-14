import curses
import atexit
from button import Button
import RPi.GPIO as GPIO
import MFRC522
import urllib.request
from io import StringIO

# init curses screen
screen = curses.initscr()

# cleanup
def exit():
    global continue_reading
    curses.setupterm()
    curses.nocbreak()
    screen.keypad(0)
    curses.echo()
    curses.endwin()
    continue_reading = False
    GPIO.cleanup()
atexit.register(exit)

# init curses
curses.noecho()
curses.curs_set(0)
screen.keypad(1)
curses.mousemask(1)

# Create an object of the class MFRC522
MIFAREReader = MFRC522.MFRC522()

#Usefull base variables
width, heigth = screen.getmaxyx()
screens = [screen]

#User info
#Creating usr screen
usrscr = curses.newwin(5, width, 0, 0)
screens.append(usrscr)
pcbid = FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0
def fetchUser(uid):
    if uid != None:
        io = StringIO(urllib.request.urlopen("https://www.infected.no/api/rest/nfc/bong/fetch.php?pcbId=" + pcbid + "&cardId=" + uid).read())
        return json.load(io)
    return None

def useBong(usr, bong):
    if usr[bong] > 0:
        usr[bong] -= 1
        return (usr, True)
    return (usr, False)

def drawUsr(scr, usr):
    scr.addstr(0,0, usr[name])

#Button part
def genButtonFunc(bong):
    def bFunc(usr):
        useBong(usr, bong)


#Initing button screen
buttonWin = curses.newwin(15, width, 5, 0)
screens.append(buttonWin)
buttns = []

#Initing buttons
polser = Button(buttonWin, "polser", genButtonFunc("polser"), 0, 0)
vafler = Button(buttonWin, "vafler", genButtonFunc("vafler"), polser.nextPropper(), 0, bottom = False)
brus = Button(buttonWin, "brus", genButtonFunc("brus"), polser.nextPropper(), polser.under(), width = vafler.width(), bottom = False)
mat = Button(buttonWin, "mat", genButtonFunc("mat"), 0, polser.under(), width=polser.width(), bottom = False)

#Adding buttons to button "bus"
buttns = [polser, vafler, brus, mat]

user = None
def draw():
    if user != None:
        drawUsr(usrscr, user)
    for b in buttns:
        b.draw()
    for s in screens:
        s.refresh()

mode = "loggin"

def uppdate():
    if mode == "loggin":
        # Get the UID of the card
        (status,tagtype) = MIFAREReader.MFRC522_Request(MIFAREReader.PICC_REQIDL)
        (status,uid) = MIFAREReader.MFRC522_Anticoll()

        # If we have the UID, continue
        if status == MIFAREReader.MI_OK:
            user = fetchUser("E004000000000000")

    # Use button
    ch = screen.getch() #Waits for key WAITING OPPERATION
    if ch == curses.KEY_MOUSE:
        (_,x,y,_,_) = curses.getmouse()
        for b in buttns:
            b.uppdate(x,y, user)

def main():
    height, width = screen.getmaxyx()
    while True:
        draw()
        uppdate()

    screen.touchwin()
    screen.refresh()

main()
