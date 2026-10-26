# Shared PowerShell 7 profile. The real $PROFILE is a stub that dot-sources this file,
# because Documents can be redirected to OneDrive.

# fish-style history autosuggestions and prefix search (PSReadLine only loads in interactive hosts)
if (Get-Module PSReadLine) {
  try {
    Set-PSReadLineOption -PredictionSource History -PredictionViewStyle InlineView
  } catch {
    # hosts without virtual terminal support can't show predictions, but the rest of the profile should still load
  }
  Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
  Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
}

function dev { Set-Location ~\Development }
function p { Set-Location ~\Development\personal }
function g { Set-Location ~\Development\grafana }
function grafana { Set-Location ~\Development\grafana }
function e { explorer.exe . }

# long listing sorted by extension, like `ls -laX`
if (Get-Command eza -ErrorAction SilentlyContinue) {
  Remove-Item Alias:ls -Force -ErrorAction SilentlyContinue
  function ls { eza -la --sort=extension --git @args }
}

# Ctrl+R fuzzy history and Ctrl+T fuzzy file search
if ((Get-Module PSReadLine) -and (Get-Command fzf -ErrorAction SilentlyContinue) -and (Get-Module -ListAvailable PSFzf)) {
  Import-Module PSFzf
  Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
}

# prompt, like tide in fish; zoxide has to come last because it wraps the prompt
if (Get-Command starship -ErrorAction SilentlyContinue) {
  Invoke-Expression (& starship init powershell)
}

# smart cd: `z grafana` jumps to the most used matching directory
if (Get-Command zoxide -ErrorAction SilentlyContinue) {
  Invoke-Expression (& { (zoxide init powershell | Out-String) })
}
