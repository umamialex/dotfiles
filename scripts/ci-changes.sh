#!/bin/bash
# Decides which CI jobs a change needs. Reads the changed file names, one per line, on stdin and
# prints lint=, linux= and windows= as true or false.
#
# A job is skipped only when every changed file is one it cannot be affected by, so a file this
# script doesn't know about runs everything. The secrets job always runs and isn't decided here.
set -euo pipefail

files="$(cat)"

# files no job looks at
untested='^(README\.md|LICENSE|\.gitignore|backups/)'
# the audit scripts are only linted, never run, so only the lint job cares
audit='^scripts/audit-'
# files only the Windows apply uses
windows_only='^(home/.*\.ps1\.tmpl|home/Scripts/|home/AppData/|home/_vimrc\.tmpl|home/dot_config/powershell/|home/dot_config/starship\.toml|fonts/)'
# files only the Linux apply uses (the tmux template is shared: Windows renders it for psmux)
linux_only='^(home/.*\.sh\.tmpl|home/dot_config/fish/|home/dot_config/mise/|home/dot_vimrc\.tmpl)'

# true if any changed file is not matched by the ignore pattern
needs() {
  if [ -z "$files" ]; then
    echo false
  elif grep -qvE "$1" <<< "$files"; then
    echo true
  else
    echo false
  fi
}

echo "lint=$(needs "$untested")"
echo "linux=$(needs "$untested|$audit|$windows_only")"
echo "windows=$(needs "$untested|$audit|$linux_only")"
