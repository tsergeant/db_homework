#!/bin/bash

USERNAME=mongo
PASSWORD=mongo

# Optional database parameter
DB="${1:-}"

# Build URI properly (include ?authSource=admin regardless)
if [ -n "$DB" ]; then
    URI="mongodb://localhost:27017/$DB?authSource=admin"
else
    URI="mongodb://localhost:27017/?authSource=admin"
fi

# Detect if we need winpty (Git Bash)
if command -v winpty >/dev/null 2>&1 && [ -t 1 ]; then
    PREFIX="winpty"
else
    PREFIX=""
fi

# Execute shell inside container
$PREFIX docker exec -it mongocontainer mongosh "$URI" \
    --username "$USERNAME" \
    --password "$PASSWORD"

