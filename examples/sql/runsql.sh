#!/bin/bash

# --- Configuration ---
DB_CONTAINER="dbcontainer"
DB_USER="student"
DB_NAME="mydb"

# 1. Check if a script name was provided
if [ -z "$1" ]; then
    echo "Usage: $0 <SQL_SCRIPT_NAME>"
    echo "Example: $0 queries.sql"
    exit 1
fi

SQL_SCRIPT="$1"

# 2. Check if the SQL file exists
if [ ! -f "$SQL_SCRIPT" ]; then
    echo "Error: SQL file '$SQL_SCRIPT' not found!"
    exit 1
fi

# --- Execution ---
echo "--- Executing SQL script: $SQL_SCRIPT on $DB_NAME as $DB_USER ---"

# The core command:
# The pipe to 'less -R' has been removed. Output streams directly to the terminal.
cat "$SQL_SCRIPT" | docker exec -i "$DB_CONTAINER" psql -U "$DB_USER" -d "$DB_NAME"

# --- Cleanup/Status ---
if [ $? -eq 0 ]; then
    echo -e "\n--- SQL execution finished successfully. ---"
else
    echo -e "\n--- SQL execution may have failed. Check the output above for psql errors. ---"
fi
