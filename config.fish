alias vi="vim"
alias ls="ls -laX --color"
alias dev="cd ~/Development"
alias p="dev; and cd personal"
alias agg="dev; and cd athletes.gg"
alias kordami="dev; and cd kordami"
alias grafana="dev; and cd grafana"
alias g="grafana"
alias tapi="tmux a -t agg-ms-api"
alias tapp="tmux a -t agg-app"
alias exe="explorer.exe ."

setenv JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
setenv ANDROID_HOME /home/suitupalex/Android
setenv SSH_ENV $HOME/.ssh/environment
setenv DOCKER_HOST unix:///var/run/docker.sock
set PATH (yarn global bin) $JAVA_HOME/bin ~/.local/bin /usr/local/go/bin $PATH

setenv DEBUG "agg:*"
setenv API_VERSION v0
setenv COOKIE_DOMAIN localhost
setenv SOCKET_URL http://localhost:8080
setenv UPDATE_INTERVAL 10
setenv AGG_JWT_AUDIENCE http://localhost:8080
setenv AGG_SUCCESS_REDIRECT http://localhost:8080/profile/settings
setenv AGG_DB_URL mongodb://localhost:27017
setenv AGG_CONTENTFUL_FETCH_INTERVAL 900

if test -e ~/.config/fish/env.fish
  . ~/.config/fish/env.fish
end
