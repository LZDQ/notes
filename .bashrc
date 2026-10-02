#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

HISTSIZE=10000
export PATH="$HOME/.local/bin:$PATH"
# For ubuntu, add this: PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

alias ls='ls --color=auto'
alias ll='ls -lA'
alias grep='grep --color=auto'
alias r=ranger
alias l='eza -lahog --time-style=iso --git'
alias g=lazygit
alias d=lazydocker
alias t=tmux
alias x='codex --yolo'

alias n='nvim'
export EDITOR=nvim

if command -v batcat &>/dev/null && ! command -v bat &>/dev/null; then
  alias bat='batcat'
fi

eval "$(fzf --bash)"
eval "$(thefuck --alias)"

export CRYPTOGRAPHY_OPENSSL_NO_LEGACY=1

# https://wiki.archlinux.org/title/Fzf#Arch_specific_fzf_uses
if command -v pacman &>/dev/null; then
  alias p='pacman -Slq | fzf --multi --preview "pacman -Si {1}" | xargs -ro sudo pacman -S'
  alias pr='pacman -Qq | fzf --multi --preview "pacman -Qi {1}" | xargs -ro sudo pacman -Rns'
  # Made by myself
  alias y='yay -Slqa | fzf --multi --preview "yay -Si {1}" | xargs -ro yay -S'
fi
# For apt
if command -v apt &>/dev/null; then
  alias a='apt-cache pkgnames | sort | fzf --multi --preview "apt-cache show --no-all-versions {1}" | xargs -ro sudo apt install'
  alias ar='dpkg-query -W -f="\${binary:Package}\n" | fzf --multi --preview "dpkg-query -s {1}" | xargs -ro sudo apt remove'
fi

# nvm
# Add local nvm setup here, for example (arch): source /usr/share/nvm/init-nvm.sh
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
__nvm_ps1() {
  # Check if nvm exists as a function/command
  if type -t nvm >/dev/null; then
    # Run nvm current, hide errors, and format the output
    nvm current 2>/dev/null | sed "/^system$/d; s/.*/(&) /"
  fi
}
export -f __nvm_ps1
PS1='$(__nvm_ps1)'"$PS1"

[[ -f /usr/share/autoenv-git/activate.sh ]] && source /usr/share/autoenv-git/activate.sh
export AUTOENV_ENV_FILENAME='.autoenv'

# http(s) proxy; if tcp 127.0.0.1:7890 exists, setup proxy
echo > /dev/tcp/127.0.0.1/7890 && export {{http,https}_proxy,{HTTP,HTTPS}_PROXY}=http://127.0.0.1:7890
alias unproxy='unset {http,https,all,no}_proxy {HTTP,HTTPS,ALL,NO}_PROXY'

if command -v wl-copy wl-paste &>/dev/null; then
    alias c='wl-copy'
    alias v='wl-paste'
elif command -v pbcopy pbpaste &>/dev/null; then
    alias c='pbcopy'
    alias v='pbpaste'
fi

uwufetch 2>/dev/null || neofetch
