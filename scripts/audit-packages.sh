#!/bin/bash
# Compares the apt packages installed here with home/.chezmoidata/packages.yaml.
#
# Only manually installed packages with optional/extra priority are considered, which
# leaves out the Ubuntu base system. Patterns in packages.audit_ignore.apt are skipped.
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if ! command -v chezmoi > /dev/null; then
  echo "chezmoi is not installed" >&2
  exit 1
fi

# print a list from packages.yaml, one entry per line
list() {
  chezmoi --source "$root" execute-template "{{ range .packages.$1 }}{{ . }} {{ end }}" 2> /dev/null | tr ' ' '\n' | sed '/^$/d'
}

tracked="$(list apt)"
if [ -z "$tracked" ]; then
  echo "could not read packages.apt from $root/home/.chezmoidata/packages.yaml" >&2
  exit 1
fi
mapfile -t ignore < <(list audit_ignore.apt)

is_ignored() {
  local pattern
  for pattern in "${ignore[@]}"; do
    # shellcheck disable=SC2053
    [[ $1 == $pattern ]] && return 0
  done
  return 1
}

echo "Installed but not in packages.yaml (manual, optional/extra priority):"
# shellcheck disable=SC2016 # dpkg-query expands its own format fields
apt-mark showmanual \
  | xargs dpkg-query -W -f='${Package} ${Priority}\n' 2> /dev/null \
  | awk '$2 == "optional" || $2 == "extra" { print $1 }' \
  | sort -u \
  | while read -r package; do
    if ! grep -qxF "$package" <<< "$tracked" && ! is_ignored "$package"; then
      echo "  $package"
    fi
  done

echo
echo "In packages.yaml but not installed:"
while read -r package; do
  if ! dpkg-query -W -f='${db:Status-Abbrev}' "$package" 2> /dev/null | grep -q '^ii'; then
    echo "  $package"
  fi
done <<< "$tracked"
