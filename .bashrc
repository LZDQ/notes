#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -lA'
alias grep='grep --color=auto'
alias r=ranger
alias l='eza -laho --time-style=iso --git'
alias g=lazygit
alias d=lazydocker

alias n='nvim'
export EDITOR=nvim

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

[ -f /etc/profile ] && source /etc/profile
export CRYPTOGRAPHY_OPENSSL_NO_LEGACY=1

# https://wiki.archlinux.org/title/Fzf#Arch_specific_fzf_uses
alias p="pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
alias pr="pacman -Qq | fzf --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns"
# Made by myself
alias y="yay -Slqa | fzf --multi --preview 'yay -Si {1}' | xargs -ro yay -S"

eval "$(thefuck --alias)"

# nvm
source /usr/share/nvm/init-nvm.sh
__nvm_ps1() {
  # Check if nvm exists as a function/command
  if type -t nvm >/dev/null; then
    # Run nvm current, hide errors, and format the output
    nvm current 2>/dev/null | sed "/^system$/d; s/.*/(&) /"
  fi
}
# For ubuntu, add this here: PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
PS1='$(__nvm_ps1)'"$PS1"
HISTSIZE=10000

export AUTOENV_ENV_FILENAME='.autoenv'

mdcat() { echo "\`${1}\`"; echo "\`\`\`${1##*.}"; cat "${1}"; echo '```'; }
export -f mdcat
# Example usage to print files with md:
# {
#   find ./vibeforces -type f -name "*.py";
#   echo 'docker-compose.yml';
# } | xargs -n1 sh -c 'mdcat "$@"; echo;' _ | xclip -selection clipboard

# http(s) proxy; if tcp localhost:7890 exists, setup proxy
echo > /dev/tcp/localhost/7890 && export HTTP_PROXY=http://127.0.0.1:7890 HTTPS_PROXY=http://127.0.0.1:7890
alias unproxy='unset http_proxy https_proxy HTTP_PROXY HTTPS_PROXY all_proxy ALL_PROXY'

uwufetch
