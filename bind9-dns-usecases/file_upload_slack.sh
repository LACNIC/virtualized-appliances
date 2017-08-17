#!/bin/bash
##
# File Upload to Slack, you need to customize your webhook url
token="xoxp-3978189224-3978189234-39802942294-d17678b1ee"
filename=$1

#https://slack.com/api/files.upload?token=xoxp-3978189224-3978189234-39802942294-d17678b1ee&content=hola%5Cncomo%5Cn&filetype=txt&filename=named.stats&title=Bind9%20Stats%20%40app1&channels=carlos_todo_integ&pretty=1 

apiurl="https://slack.com/api/files.upload?token=$token&pretty=1"
#echo $rpccall

curl -X POST  \
 -F "channels=#carlos_todo_integ" \
 -F "title=Named Stats $(date) - $(hostname)" \
 -F "file=@named.stats" \
 -F "filename=named.stats.txt" \
 -F "filetype=txt" \
 $apiurl > post_to_slack_result.txt

echo uploaded!
