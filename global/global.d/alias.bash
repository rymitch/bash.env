alias dir='LC_COLLATE=C ls -ahlN --color=auto --group-directories-first'
alias ls='LC_COLLATE=C ls -hN --color=auto --group-directories-first'

alias bc='bc -l'
alias clear='printf "\033c"'
alias cls='printf "\033c"'
alias df='df -hx "squashfs"'
alias du='du -h'
alias grep='grep --color=auto'
alias myip='curl -w "\n" ifconfig.me'

command -v cygstart >/dev/null 2>&1 && alias open='cygstart'
