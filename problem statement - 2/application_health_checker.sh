#!/bin/bash

# URL of the application to check
URL="https://www.accuknox.com/"

EXPECTED_STATUS_CODE=200

# To check the application status
# Send an HTTP request and get the status code
STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$URL")
    
# Compare the status code with the expected status code
if [[ "$STATUS_CODE" -eq "$EXPECTED_STATUS_CODE" ]]; then
    echo "The application is UP. Status code: $STATUS_CODE"
else
    echo "The application is DOWN. Status code: $STATUS_CODE"
fi
