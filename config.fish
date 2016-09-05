alias vi="vim"
alias ls="ls -laX --color"
alias dev="~/Development"
alias me="dev; and cd martin-experiments"
alias p="dev; and cd personal"

setenv SSH_ENV $HOME/.ssh/environment
setenv NPM_PACKAGES $HOME/.npm-packages
setenv PATH $NPM_PACKAGES/bin $PATH
setenv MANPATH $NPM_PACKAGES/share/man:(manpath)
