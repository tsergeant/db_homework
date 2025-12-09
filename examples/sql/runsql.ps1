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

# 2. Execute the Docker command.
#    a. The `-i` (interactive) flag is still crucial for piping input to the container process.
#    b. We use '$SqlContent | docker exec...' to pass the content as standard input.
#    c. The output of the Docker command is captured.
$PsqlOutput = $SqlContent | docker exec -i $DB_CONTAINER psql -U $DB_USER -d $DB_NAME

# 3. Display the output in a scrollable viewer (similar to 'less -R').
#    'Out-Host -Paging' makes the output scrollable line by line.
$PsqlOutput | Out-Host -Paging

# --- Cleanup/Status ---
if ($LASTEXITCODE -eq 0) {
    Write-Host "`n--- SQL execution finished successfully. ---"
} else {
    Write-Host "`n--- SQL execution may have failed. Check the output above for psql errors. ---"
}
