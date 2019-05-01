# setup.bash
#
# call from .bash_profile and .bashrc

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\u@\h \[\033[33m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "

export DOCKER_ID_USER="funkytwig"

alias e=emacs
alias gis='git status'
alias gim='git commit -m'
alias gia='git add '
alias vi="echo 'Use emacs'"
alias vi="echo 'Use emacs'"