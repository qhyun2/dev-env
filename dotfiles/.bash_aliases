
alias mv="mv -i"           # -i prompts before overwrite
alias mkdir="mkdir -p"     # -p make parent dirs as needed
alias df="df -h"           # -h prints human readable format
alias free="free -h"       # -h prints human readable format
alias apt="sudo apt -y"
alias ffmpeg="ffmpeg -hide_banner"
alias ffprobe="ffprobe -hide_banner"

alias we="explorer.exe ."  # open cwd in windows explorer (for wsl)

alias fucking="sudo "

# git
alias g="git"
alias gs="git status"
alias gaa="git add ."

# custom ls-logo for current wsl
alias ls='logo-ls -h'

# ls aliases
alias ll='ls -Al'
alias l='ls -l'
alias wh='cd /mnt/c/Users/Howard'
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# reload shell
alias reload="exec ${SHELL} -l"

# print paths
alias path='echo -e ${PATH//:/\\n}'

# cpp
alias nodemonmake='nodemon -e cc,h --exec "make || exit 1"'

# youtube-dl
alias youtube-dl-audio='youtube-dl --ignore-errors --output "%(title)s.%(ext)s" --extract-audio --audio-format mp3'

# terraform
alias tf="terraform"
