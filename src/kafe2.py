#!/usr/bin/env python
# -*- coding: utf-8 -*-
import requests
#import json


pcbid = "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0"
def fetchUser(uid):
    if uid != None:
        r = requests.get(url="https://www.infected.no/api/rest/nfc/bong/fetch.php?pcbId=" + pcbid + "&cardId=" + uid)
        return r.json()
    return None

print(fetchUser("E004000000000000"))
