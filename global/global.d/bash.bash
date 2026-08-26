HISTFILESIZE=100000
HISTIGNORE=cls:dir:exit:fg:ls
HISTSIZE=10000

set -o vi
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'

shopt -s checkjobs
shopt -s extglob
shopt -s globstar
shopt -s histappend

umask 022
