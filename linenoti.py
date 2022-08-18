import requests
import urllib
#https://notify-bot.line.me/my/
LINE_ACCESS_TOKEN   = "KMkTAy88Xkz852xiqvgqcBdU3YhiYPYCObrWVNKuZlx"
url                 = "https://notify-api.line.me/api/notify"
data                = "Test notify demo."
message             = urllib.urlencode({"message":data})

headers = {
    'Content-Type':'application/x-www-form-urlencoded',
    "Authorization":"Bearer "+LINE_ACCESS_TOKEN
}
r = requests.post(url, headers=headers, data=message)

print(r.status_code+" "+r.text[:300])
