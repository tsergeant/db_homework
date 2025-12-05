#!/bin/sh

if [ -z "$1" ]; then
	echo "Usage: ./run.sh <MainClass>"
	exit 1
fi

CLASS="$1"
JAR_NAME="postgresql-42.7.8.jar"

# search current directory
if [ -f "$JAR_NAME" ]; then
	JAR_PATH="./$JAR_NAME"
# search parent directory
elif [ -f "../$JAR_NAME" ]; then
	JAR_PATH="../$JAR_NAME"
else
	echo "ERROR: Cannot find $JAR_NAME in current or parent directory."
	exit 1
fi

CP=".:$JAR_PATH"

java -cp "$CP" "$CLASS"

