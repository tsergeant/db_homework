param (
    [Parameter(Mandatory=$true)]
    [string]$Database,

    [Parameter(Mandatory=$true)]
    [string]$Collection,

    [Parameter(Mandatory=$true)]
    [string]$FileName
)

# IMPORTANT: connect using the container hostname, not localhost
$Uri = "mongodb://mongo:mongo@mongocontainer:27017/${Database}?authSource=admin"

if (-not (Test-Path $FileName)) {
    Write-Host "File not found: $FileName"
    exit 1
}

$BashCmd = "mongoimport --uri `"$Uri`" --collection `"$Collection`" --type json --jsonArray"

Get-Content $FileName | docker exec -i mongocontainer bash -c "$BashCmd"
