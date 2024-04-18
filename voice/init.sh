#!/bin/bash
 
echo "{\"api_key\" : \"$API_KEY\", \"key_id\":\"$API_KEY_ID\"}" > credentials.json
 
gen3-client configure --profile=bridge2ai --cred=credentials.json  --apiendpoint=https://$GEN3_ENDPOINT
gen3-client auth --profile=bridge2ai
g3t clone --project_id=bridge2ai-Voice --data_type=all
 
cd bridge2ai-Voice;
tar -xf bridge2ai-voice-corpus-1.tar.gz