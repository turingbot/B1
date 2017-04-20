#!/bin/bash
COUNTER=1
while(true) do
./beyond.sh
curl "https://api.telegram.org/bot370933143:AAHxPDi4fUaER4HfP70AXLbYKRxndw28eOk/sendmessage" -F "chat_id=308444837" -F "text=#NEWCRASH-#TeleBeyond-Reloaded-${COUNTER}-times"
let COUNTER=COUNTER+1 
done