import requests

pcbid = "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF"
def fetch(tid):
    if tid != None:
        r = requests.get(url="https://www.infected.no/api/rest/nfc/ticket/user/fetch.php?pcbId=" + pcbid + "&ticketId=" + tid)
        return r.json()
    return None

print(fetch("E004000000000000"))

