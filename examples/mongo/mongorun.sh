#!/bin/bash

USERNAME=mongo
PASSWORD=mongo

if [ $# -ne 2 ]; then
    echo "Usage: mongorun.sh <database> <scriptfile>"
    exit 1
fi

DB="$1"
SCRIPT="$2"

if [ ! -f "$SCRIPT" ]; then
    echo "Script file not found: $SCRIPT"
    exit 1
fi

URI="mongodb://localhost:27017/${DB}?authSource=admin"

# Detect winpty for Git Bash
if command -v winpty >/dev/null 2>&1 && [ -t 1 ]; then
    PREFIX="winpty"
else
    PREFIX=""
fi

echo "Copying script into container..."
docker cp "$SCRIPT" mongocontainer:/tmp/runme.js

echo "Running script and entering interactive shell..."

ARGS=(
    "mongosh"
    "$URI"
    "--username" "$USERNAME"
    "--password" "$PASSWORD"
    "--file" "//tmp/runme.js"
    "--shell"
)

$PREFIX docker exec -it mongocontainer "${ARGS[@]}"

