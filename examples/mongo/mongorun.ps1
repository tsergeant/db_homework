param (
    [Parameter(Mandatory=$true)]
    [string]$Database,

    [Parameter(Mandatory=$true)]
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
$Uri = "mongodb://localhost:27017/${Database}?authSource=admin"

#----- Copy script into container -----
Write-Host "Copying script into container..."
docker cp ${ScriptFile} "${Container}:/tmp/runme.js"

#----- Build argument list for mongosh -----
# Note: Each argument MUST be separate, just like in Bash.
$Args = @(
    "mongosh",
    $Uri,
    "--username", $Username,
    "--password", $Password,
    "--file", "/tmp/runme.js",
    "--shell"
)

Write-Host "Running script and entering interactive shell..."

#----- Execute mongosh inside container -----
docker exec -it $Container @Args

