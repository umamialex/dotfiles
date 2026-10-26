# Compares the winget packages installed here with home/.chezmoidata/packages.yaml.
#
# Packages matching packages.audit_ignore.winget are skipped when listing untracked packages.
# winget_server counts as tracked only if you answered yes to the "Home server" prompt.
$ErrorActionPreference = 'Stop'

$root = Split-Path $PSScriptRoot -Parent

if (-not (Get-Command chezmoi -ErrorAction SilentlyContinue)) { throw 'chezmoi is not installed' }

$data = chezmoi --source $root data --format json 2> $null | ConvertFrom-Json
if (-not $data.packages.winget) { throw "could not read packages.winget from $root\home\.chezmoidata\packages.yaml" }

$packages = $data.packages
$isServer = ($data.PSObject.Properties.Name -contains 'server') -and $data.server
$tracked = @($packages.winget) + @($packages.winget_desktop)
if ($isServer) { $tracked += @($packages.winget_server) }
$ignore = @($packages.audit_ignore.winget)

function Test-Ignored($id) {
  foreach ($pattern in $ignore) { if ($id -like $pattern) { return $true } }
  return $false
}

# winget export lists everything from the winget source, including dependencies
$export = Join-Path ([IO.Path]::GetTempPath()) "winget-audit-$PID.json"
try {
  winget export --output $export --source winget --accept-source-agreements | Out-Null
  $installed = @((Get-Content $export -Raw | ConvertFrom-Json).Sources.Packages.PackageIdentifier | Sort-Object -Unique)
} finally {
  Remove-Item $export -Force -ErrorAction SilentlyContinue
}

Write-Host 'Installed but not in packages.yaml:'
$installed | Where-Object { $tracked -notcontains $_ -and -not (Test-Ignored $_) } | ForEach-Object { Write-Host "  $_" }

# ask winget about each one, since export misses apps installed outside winget (Chrome, Discord)
Write-Host ''
Write-Host 'In packages.yaml but not installed:'
foreach ($id in $tracked) {
  winget list --id $id --exact --source winget --accept-source-agreements | Out-Null
  if ($LASTEXITCODE -ne 0) { Write-Host "  $id" }
}
foreach ($id in @($packages.winget_store)) {
  winget list --id $id --exact --source msstore --accept-source-agreements | Out-Null
  if ($LASTEXITCODE -ne 0) { Write-Host "  $id (Microsoft Store)" }
}
