parse_git_branch() {
    if [ $(git rev-parse --is-inside-work-tree &>/dev/null; echo "${?}") == '0' ]; then 
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
    fi
}

export PS1="\u \w\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "

alias vim="/usr/local/Cellar/vim/8.1.1100/bin/vim"
alias v=vim
alias pip="pip3"
alias python="python3"



alias chrome="open -a \"Google Chrome\""
alias st="cd ~/sites/stonetorch.com"
alias stup="cd ~/sites/stonetorch.com && php bin/console server:start"
alias gst="git status"
alias st="cd ~/sites/stonetorch.com"
alias gcob="git checkout -b"
alias gco="git checkout"
alias gl="git log --graph --decorate --pretty=oneline --abbrev-commit"
alias dc=docker-compose

#alias gbd="git branch -d $(git branch --merged |tail -n +2)"

export PATH="/usr/local/opt/php@7.1/bin:$PATH"
export PATH="/usr/local/opt/php@7.1/sbin:$PATH"
export PATH="/usr/local/opt/sqlite/bin:$PATH"
export PATH="/usr/local/opt/icu4c/sbin:$PATH"
