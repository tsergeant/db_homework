# `loadmongo` – MongoDB JSON Import Helper

This project provides two helper scripts for loading JSON array files into a MongoDB database running inside a Docker container.

Supported environments:

- **macOS / Linux / Git Bash on Windows** → `loadmongo.sh`
- **PowerShell (Windows)** → `loadmongo.ps1`

Both scripts let you import sample data easily without having to manually copy files into the container.

## 📦 Requirements

Before using the scripts, you must have:

- Docker installed and running  
- A MongoDB container named **`mongocontainer`**  
- MongoDB configured with username/password `mongo / mongo`  
- Authentication database set to **admin**
- JSON files containing a **JSON array**

## 🚀 Using `loadmongo.sh` (macOS, Linux, Git Bash)

### Usage

```bash
./loadmongo.sh <database> <collection> <json-array-file>
```

### Example

```bash
./loadmongo.sh demo users users.json
```

## 🪟 Using `loadmongo.ps1` (PowerShell)

### Usage

```powershell
.\loadmongo.ps1 <database> <collection> <json-array-file>
```

### Example

```powershell
.\loadmongo.ps1 demo users users.json
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
loadmongo.sh
loadmongo.ps1
README.md
```
