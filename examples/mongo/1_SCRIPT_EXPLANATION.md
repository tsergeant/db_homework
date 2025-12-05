
# How to Use the Scripts

## Overview

There are two pairs of scripts:
- mongoshell.sh and mongoshell.ps1
- mongorun.sh and mongoshell.ps1

If you are using VSCode Terminal in Windows use the .ps1 scripts.
If you are using MacOS or Windows Git Bash use the .sh scripts.

- Authentication enabled (username/password: `mongo` / `mongo`)
- Git Bash, macOS, Linux (for the `.sh` script)
- PowerShell (for the `.ps1` script)

---

## Assumptions
- You have a running docker container based on the docker-compose.yml provided in this repo
- You have not changed credentials

---

## The mongoshell Script

### What It Does
- Purpose: Connect to your docker mongocontainer and provide an interactive prompt.
- This will allow you to interact with the mongo server
- Good for testing various commands

### Usage
```
./mongoshell.sh [<database>]
```
NOTE: database name is optional.

Example 1: Connect to default test database
```
./mongorun.sh
```

Example 2: Connect to database named hw13
```
./mongorun.sh hw13
```

---

## The mongorun Script

### What It Does
- Purpose: Executes a local mongo script in mongocontainer and leaves you connected to interact with the results.
- This will allow you to write mongo scripts in VSCode and test them using a single command
- Since it leaves you connected you can inspect results, run functions, etc.

### Usage
```
.\mongorun.sh <database> <scriptfile>
```
NOTE: Database name and name of local script file are required.

Example: Execute the albumdb.js file in the albums database in the mongocontainer

```
./mongorun.sh albums albumdb.js
```

