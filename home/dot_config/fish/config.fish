fish_add_path -g ~/.local/bin ~/go/bin

if test -f ~/.config/fish/env.fish
  source ~/.config/fish/env.fish
end

if status is-interactive
  # abbreviations expand as you type, so history keeps the full command
  abbr -a vi vim
  abbr -a k kubectl
  abbr -a dev 'cd ~/Development'
  abbr -a p 'cd ~/Development/personal'
  abbr -a g 'cd ~/Development/grafana'
  abbr -a grafana 'cd ~/Development/grafana'
  abbr -a e 'explorer.exe .'

  alias ls='ls -laX --color=auto'
  alias fw='powershell.exe ~/Development/personal/dotfiles/windows/wsl-firewall.ps1'
  alias s='fw && sudo service ssh start'

  if type -q mise
    mise activate fish | source
  end
end
