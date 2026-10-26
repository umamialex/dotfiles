# Compares the winget packages installed here with home/.chezmoidata/packages.yaml.
#
# The tracked list is rendered from the same template the install script uses, so it follows the
# answers given to chezmoi init (dev, work, server and the detected GPU). Packages matching
# packages.audit_ignore.winget, and anything on the winget_remove list, are skipped when listing
# untracked packages. This script only reports. The prompt that tracks or uninstalls them runs in
# chezmoi apply.
$ErrorActionPreference = 'Stop'

$root = Split-Path $PSScriptRoot -Parent

if (-not (Get-Command chezmoi -ErrorAction SilentlyContinue)) { throw 'chezmoi is not installed' }

$data = chezmoi --source $root data --format json 2> $null | ConvertFrom-Json
if (-not $data.packages.winget) { throw "could not read packages.winget from $root\home\.chezmoidata\packages.yaml" }

$packages = $data.packages

# chezmoi reads the template from stdin, because quotes in a native command argument get lost in PowerShell
function Get-Rendered($name) {
  @("{{ includeTemplate `"$name`" . }}" | chezmoi --source $root execute-template) | Where-Object { $_ }
}

$tracked = @(Get-Rendered 'winget-ids')
$storeIds = @(Get-Rendered 'winget-store-ids')
$remove = @($packages.winget_remove)
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
$installed | Where-Object { $tracked -notcontains $_ -and $remove -notcontains $_ -and -not (Test-Ignored $_) } | ForEach-Object { Write-Host "  $_" }

# ask winget about each one, since export misses apps installed outside winget (Chrome, Discord)
Write-Host ''
Write-Host 'In packages.yaml but not installed:'
foreach ($id in $tracked) {
  winget list --id $id --exact --source winget --accept-source-agreements | Out-Null
  if ($LASTEXITCODE -ne 0) { Write-Host "  $id" }
}
foreach ($id in $storeIds) {
  winget list --id $id --exact --source msstore --accept-source-agreements | Out-Null
  if ($LASTEXITCODE -ne 0) { Write-Host "  $id (Microsoft Store)" }
}
