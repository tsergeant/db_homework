param (
    [Parameter(Mandatory=$true, Position=0)]
    [string]$Database,

    [Parameter(Mandatory=$true, Position=1)]
    [string]$ScriptFile
)

#----- Settings -----
$Username = "mongo"
$Password = "mongo"
$Container = "mongocontainer"

#----- Validate script file -----
if (-Not (Test-Path $ScriptFile)) {
    Write-Error "Script file not found: $ScriptFile"
    exit 1
}

#----- Build connection URI -----
# CORRECTED: INCLUDE the database path in the URI.
$Uri = "mongodb://127.0.0.1:27017/${Database}?authSource=admin"

#----- Copy script into container -----
Write-Host "Copying script into container..."
docker cp ${ScriptFile} "${Container}:/tmp/runme.js"

#----- Build argument list for mongosh -----
$Args = @(
    "mongosh",
    $Uri,
    "--username", $Username,
    "--password", $Password,
    "--file", "/tmp/runme.js",
    "--shell"
    # REMOVED: The positional $Database argument that caused the "Loading file: hw13" error
)

Write-Host "Executing script and entering interactive shell. Press CTRL+D or type 'exit' to quit."

#----- Execute mongosh inside container (INTERACTIVE) -----
docker exec -it $Container @Args
