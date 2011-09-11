#!/bin/bash
. ./prizzm_setup/functions

server=${1:-development}
asset_host=assets-$server.prizzm.com
server_mongolab_uri=`$server config | grep MONGOLAB_URI`
echo $server_mongolab_uri
export PUSH_DEMO=true
export S3_ASSET_HOST=$asset_host
echo $server
echo $S3_ASSET_HOST
#rds $server
unset PUSH_DEMO
unset S3_ASSET_HOST
#db push $server
#rds
