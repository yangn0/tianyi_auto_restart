import requests
import re

mao_url = "192.168.1.1"
username="useradmin"
password="ruznj"

login_url = "http://%s/login.cgi" % mao_url

r = requests.post(login_url, data={
    "username": "useradmin",
    "password": "ruznj"})

sessionid = re.search("var mysessionid=(.+?);", r.text)[1]

restart_url = "http://%s/restartGateWay.json?sessionKey=%s" % (
    mao_url, sessionid)

try:
    r = requests.get(restart_url, json={
        "action": "restartGateWay",
        "actionid": "11"
    })
except:
    pass

