alias vi="vim"
alias ls="ls -laX --color"
alias dev="cd ~/Development"
alias p="dev; and cd personal"
alias agg="dev; and cd athletes.gg"
alias ctrl="agg; and cd ctrl"
alias tmux="env TERM=screen-256color-bce tmux"

setenv SSH_ENV $HOME/.ssh/environment
setenv DOCKER_HOST localhost:2375
set PATH ~/.npm-global/bin $PATH

