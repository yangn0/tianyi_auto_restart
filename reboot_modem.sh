#!/bin/bash
loginfo=$(curl -s -L http://192.168.1.1/cgi-bin/luci -X POST -c cookies.txt -d 'username=useradmin&psd=************')
 
function mygetip()
{
  ipinfo=$(curl -s -b cookies.txt http://192.168.1.100/cgi-bin/luci/admin/settings/gwinfo?get=all)
  WanIp=$(echo $ipinfo | sed 's/,/\n/g' | grep -w WANIP)
  echo WANIP information —— $WanIp
}
 
function myrestart()
{
  mytoken=$(echo $loginfo |sed 's/{/\n/g' | grep token |awk '/realRestart/{print $2}' |sed $'s/\'//g')
  mytoken='token='$mytoken
  
  curl -s -b cookies.txt http://192.168.1.1/cgi-bin/luci/admin/reboot --data $mytoken
  if [ $? -ne 0 ]; then
    echo $mytoken reboot failed
  else
    echo $mytoken rebooting!
  fi
}
#mygetip
myrestart
