param(
	[string]$class
)

if (-not $class) {
	Write-Host "Usage: ./run.ps1 <MainClass>"
	exit
}

# jar name to search for
$jarName = "postgresql-42.7.8.jar"

# search in current directory
$jarPath = Join-Path (Get-Location) $jarName

if (-not (Test-Path $jarPath)) {
	# search in parent directory
	$parent = Split-Path (Get-Location)
	$jarPath = Join-Path $parent $jarName
}

if (-not (Test-Path $jarPath)) {
	Write-Host "ERROR: Cannot find $jarName in current or parent directory."
	exit 1
}

# PowerShell requires quotes around -cp argument because of semicolon
$cp = ".;$jarPath"

java -cp "$cp" $class

