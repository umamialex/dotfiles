alias vi="vim"
alias ls="ls -laX --color"
alias dev="cd ~/Development"
alias p="dev; and cd personal"
alias agg="dev; and cd athletes.gg"
alias ctrl="agg; and cd ctrl"
alias tapi="tmux a -t agg-ms-api-v1"

setenv JAVA_HOME /mnt/c/Users/alex/Development/tenfold/jdk8
setenv ANDROID_HOME /home/suitupalex/Android
setenv SSH_ENV $HOME/.ssh/environment
setenv DOCKER_HOST localhost:2375
set PATH ~/.npm-global/bin $JAVA_HOME/bin $PATH

setenv NODE_ENV development
setenv DEBUG "agg:*"
setenv API_VERSION v0
setenv COOKIE_DOMAIN localhost
setenv SOCKET_URL http://localhost:8080
setenv UPDATE_INTERVAL 10
setenv AGG_JWT_AUDIENCE http://localhost:8080
setenv AGG_SUCCESS_REDIRECT http://localhost:8080/profile/settings
setenv AGG_DB_URL mongodb://localhost:27017
setenv AGG_CONTENTFUL_FETCH_INTERVAL 900
