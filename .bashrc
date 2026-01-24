#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -lA'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

alias n='nvim'
export EDITOR=nvim

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

[ -f /etc/profile ] && source /etc/profile
export CRYPTOGRAPHY_OPENSSL_NO_LEGACY=1
export PATH="$PATH:/home/ldq/.dotnet/tools"
export PATH="$PATH:/home/ldq/go/bin"

# fortune | cowsay -f $(cowsay -l | shuf -n1) | lolcat
fortune | cowsay -f $(echo "default daemon dragon dragon-and-cow tux turkey stegosaurus sheep moose eyes" | tr " " "\n" | shuf -n1) | lolcat

# show nvm current node version if not system
PS1='$(nvm current | sed "/^system$/d; s/.*/(&) /")'"$PS1"

# https://wiki.archlinux.org/title/Fzf#Arch_specific_fzf_uses
alias p="pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
alias pr="pacman -Qq | fzf --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns"
# Made by myself
alias y="yay -Slqa | fzf --multi --preview 'yay -Si {1}' | xargs -ro yay -S"

# source /opt/esp-idf/export.sh
alias r=ranger
alias l='eza -laho --time-style=iso --git'


eval "$(thefuck --alias)"

source /usr/share/nvm/init-nvm.sh

HISTSIZE=10000

export AUTOENV_ENV_FILENAME='.autoenv'

mdcat() { echo "\`${1}\`"; echo "\`\`\`${1##*.}"; cat "${1}"; echo '```'; }
export -f mdcat
# Example usage to print files with md:
# {
#   find ./vibeforces -type f -name "*.py";
#   echo 'docker-compose.yml';
# } | xargs -n1 sh -c 'mdcat "$@"; echo;' _ | xclip -selection clipboard

uwufetch
