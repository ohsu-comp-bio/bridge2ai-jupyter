#!/bin/bash

echo "{\"api_key\" : \"$API_KEY\", \"key_id\":\"$API_KEY_ID\"}" > credentials.json

gen3-client configure --profile=bridge2ai --cred=credentials.json  --apiendpoint=https://$GEN3_ENDPOINT
gen3-client auth --profile=bridge2ai
g3t clone --project_id=$1 --data_type=all