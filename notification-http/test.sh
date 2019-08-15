JSON=$(cat -)
WORKFLOW_NAME=$(echo $JSON | jq ".workflow_name" -r)
MESSAGE=$(echo $JSON | jq ".message" -r)
ATTEMPT_ID=$(echo $JSON | jq ".attempt_id" -r)
SESSION_ID=$(echo $JSON | jq ".session_id" -r)

PAYLOAD=$(cat << EOS
payload={"channel": "#channel",
                  "username": "webhookbot",
                  "attachments": [{"color": "danger",
                                   "title": "<!channel>\n[ERROR] $WORKFLOW_NAME",
                                   "text": "$MESSAGE",
                                   "fields": [{"title": "Session",
                                               "value": "https://............/sessions/$SESSION_ID",
                                               "short": false},
                                              {"title": "Attempt",
                                               "value": "https://............/attempts/$ATTEMPT_ID",
                                               "short": false}]}]}
EOS
)

echo "${PAYLOAD}"
curl -X POST --data-urlencode "${PAYLOAD}" http://................
