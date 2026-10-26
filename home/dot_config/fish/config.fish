alias vi="vim"
alias ls="ls -laX --color"
alias dev="cd ~/Development"
alias p="dev; and cd personal"
alias grafana="dev; and cd grafana"
alias g="grafana"
alias e="explorer.exe ."
alias k="kubectl"
alias fw="powershell.exe ~/Development/personal/dotfiles/windows/wsl-firewall.ps1"
alias s="fw && sudo service ssh start"

set -gx PATH ~/.local/bin ~/go/bin $PATH

if test -e ~/.config/fish/env.fish
  source ~/.config/fish/env.fish
end

if type -q mise
  mise activate fish | source
end
