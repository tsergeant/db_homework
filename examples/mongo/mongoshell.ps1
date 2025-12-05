param (
    [string]$Database = ""
)

# Connection parameters
$Username = "mongo"
$Password = "mongo"

# Build correct URI with authSource=admin
if ($Database -ne "") {
    $Uri = "mongodb://localhost:27017/${Database}?authSource=admin"
} else {
    $Uri = "mongodb://localhost:27017/?authSource=admin"
}

Write-Host "Using URI: $Uri"

# Execute mongosh inside the container
docker exec -it mongocontainer mongosh "$Uri" `
    --username "$Username" `
    --password "$Password"

