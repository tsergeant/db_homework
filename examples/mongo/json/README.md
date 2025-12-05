# `mongoload` – MongoDB JSON Import Helper

This project provides two helper scripts for loading JSON array files into a MongoDB database running inside a Docker container.

Supported environments:

- **macOS / Linux / Git Bash on Windows** → `mongoload.sh`
- **PowerShell (Windows)** → `mongoload.ps1`

Both scripts let you import sample data easily without having to manually copy files into the container.

## 📦 Requirements

Before using the scripts, you must have:

- Docker installed and running  
- A MongoDB container named **`mongocontainer`**  
- MongoDB configured with username/password `mongo / mongo`  
- Authentication database set to **admin**
- JSON files containing a **JSON array**

## 🚀 Using `mongoload.sh` (macOS, Linux, Git Bash)

### Usage

```bash
./mongoload.sh <database> <collection> <json-array-file>
```

### Example

```bash
./mongoload.sh demo users users.json
```

## 🪟 Using `mongoload.ps1` (PowerShell)

### Usage

```powershell
.\mongoload.ps1 <database> <collection> <json-array-file>
```

### Example

```powershell
.\mongoload.ps1 demo users users.json
```

## 🧪 Example JSON File

```json
[
  { "city": "Abilene", "state": "TX" },
  { "city": "Charleston", "state": "AR" }
]
```

## 📁 File List

```
mongoload.sh
mongoload.ps1
README.md
```
