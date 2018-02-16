import requests

pcbid = "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF"
def checkIn(tid):
    if tid != None:
        r = requests.get(url="https://www.infected.no/api/rest/nfc/ticket/checkIn.php?pcbId=" + pcbid + "&ticketId=" + tid)
        return r.json()
    return None

print(checkIn("E004000000000000"))

