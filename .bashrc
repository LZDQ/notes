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

cd_hook() {
	# Activate Conda environment when cd into some directories under $HOME
	local cur_dir=$PWD
	local old_dir=$OLDPWD
	for env_name in 'AI' 'CTF' 'pyforces-dev'; do
		# if cd into dir from outside
		if [[ "$cur_dir" == "$HOME/$env_name"* && "$old_dir" != "$HOME/$env_name"* ]]; then
			# Activate the Conda environment if not already activated
			if [[ "$CONDA_DEFAULT_ENV" != "$env_name" ]]; then
				echo "Activating Conda environment $env_name..."
				conda activate $env_name
				break
			fi
		fi
	done

	# nvm use if there is a .nvmrc
	[ -f ".nvmrc" ] && nvm use
	return 0
}

# https://wiki.archlinux.org/title/Fzf#Arch_specific_fzf_uses
alias p="pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
alias pr="pacman -Qq | fzf --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns"
# Made by myself
alias y="yay -Slqa | fzf --multi --preview 'yay -Si {1}' | xargs -ro yay -S"

# Add a PROMPT_COMMAND to execute the function each time the prompt is displayed
# PROMPT_COMMAND="auto_activate_conda; $PROMPT_COMMAND"

# source /opt/esp-idf/export.sh
alias r=ranger
alias l='eza -laho --time-style=iso --git'


eval "$(thefuck --alias)"

source /usr/share/nvm/init-nvm.sh

HISTSIZE=10000

custom_cd() {
	builtin cd "$@" && cd_hook
}
# run it first and then wrap cd to custom one
cd_hook
alias cd=custom_cd

uwufetch

