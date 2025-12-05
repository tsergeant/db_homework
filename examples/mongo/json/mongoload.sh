#!/bin/bash
# USAGE: mongoload db_name collection_name file_with_json_array

USERNAME=mongo
PASSWORD=mongo

if [ $# -ne 3 ]
   then
      echo "Usage: mongoload db_name collection_name file_with_json_array"
      exit 1
fi

DB=$1
COLLECTION=$2
FILENAME=$3
URI="mongodb://mongo:mongo@localhost:27017/$DB?authSource=admin"


docker exec -i mongocontainer bash -c "mongoimport --uri $URI --collection $COLLECTION --type json --jsonArray" < "$FILENAME"
