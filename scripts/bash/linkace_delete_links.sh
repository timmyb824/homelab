#!/bin/bash

TOKEN=$LINKACE_TOKEN

## simple script to delete all links from linkace ##
while [ "$(curl -s --request GET url http://linkace.local.timmybtech.com/api/v1/links --header "Authorization: Bearer ${TOKEN}" --header 'Content-Type: application/json' --header 'accept: application/json' | jq '.total')" -gt 10 ];

do
  for LINK in $(curl -s --request GET url http://linkace.local.timmybtech.com/api/v1/links --header "Authorization: Bearer ${TOKEN}" --header 'Content-Type: application/json' --header 'accept: application/json' | jq '.data[].id')
  do
    echo "Deleting ${LINK}"
    curl -s --request DELETE url http://linkace.local.timmybtech.com/api/v1/links/${LINK} --header "Authorization: Bearer ${TOKEN}" --header 'Content-Type: application/json' --header 'accept: application/json' > /dev/null
    echo "..Deleted Successfully"
  done
  # workaround for being rate limited
  sleep 15
done