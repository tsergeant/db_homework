param(
    [Parameter(Mandatory=$true)]
    [string]$SqlScriptPath
)

# --- Configuration ---
$DB_CONTAINER = "dbcontainer"
$DB_USER      = "student"
$DB_NAME      = "mydb"

# --- Validation ---
if (-not (Test-Path $SqlScriptPath)) {
    Write-Error "Error: SQL file '$SqlScriptPath' not found!"
    exit 1
}

# --- Execution ---
Write-Host "--- Executing SQL script: $SqlScriptPath on $DB_NAME as $DB_USER ---"

# 1. Get the content of the SQL script.
$SqlContent = Get-Content -Path $SqlScriptPath -Raw

# 2. Execute the Docker command and stream output directly.
#    The script pipes the content ($SqlContent) directly into the 'docker exec' command.
#    The output from the 'psql' command inside the container is now automatically
#    written to the host console, bypassing any variable capture or paging.
$SqlContent | docker exec -i $DB_CONTAINER psql -U $DB_USER -d $DB_NAME

# --- Cleanup/Status ---
# $LASTEXITCODE will still hold the exit code of the last executed external command (docker exec)
if ($LASTEXITCODE -eq 0) {
    Write-Host "`n--- SQL execution finished successfully. ---"
} else {
    Write-Host "`n--- SQL execution may have failed. Check the output above for psql errors. ---"
}
