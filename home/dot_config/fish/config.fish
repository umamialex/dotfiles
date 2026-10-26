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

  if type -q mise
    mise activate fish | source
  end

  # smart cd: `z grafana` jumps to the most used matching directory
  if type -q zoxide
    zoxide init fish | source
  end

  # long listing sorted by extension, like `ls -laX`
  if type -q eza
    alias ls='eza -la --sort=extension --git'
  else
    alias ls='ls -laX --color=auto'
  end
end
