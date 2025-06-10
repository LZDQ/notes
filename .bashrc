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

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

[ -f /etc/profile ] && source /etc/profile
export CRYPTOGRAPHY_OPENSSL_NO_LEGACY=1
export PATH="$PATH:/home/ldq/.dotnet/tools"
export PATH="$PATH:/home/ldq/go/bin"

# fortune | cowsay -f $(cowsay -l | shuf -n1) | lolcat
fortune | cowsay -f $(echo "default daemon dragon dragon-and-cow tux turkey stegosaurus sheep moose eyes" | tr " " "\n" | shuf -n1) | lolcat

# Function to activate Conda environment when cd into ~/AI or ~/CTF from outside
auto_activate_conda() {
	# echo 'auto activate conda'
    
    # Get the current directory
    local cur_dir=$PWD
	local old_dir=$OLDPWD
	# echo cur_dir $cur_dir
	# echo old_dir $old_dir
    
	for env_name in 'AI' 'CTF'; do
		# if [[ "$cur_dir" == "$HOME/$env_name"* ]]; then
		# 	echo 'cur match' $env_name
		# else
		# 	echo 'cur mismatch' $env_name
		# fi
		# if [[ "$old_dir" == "$HOME/$env_name"* ]]; then
		# 	echo 'old match' $env_name
		# else
		# 	echo 'old mismatch' $env_name
		# fi

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
}

# Export the function to make it available
# probably useless
# export -f auto_activate_conda

# wrapper for cd
alias cd="cd_and_activate_env"

cd_and_activate_env() {
    builtin cd "$@" && auto_activate_conda
}

auto_activate_conda

# https://wiki.archlinux.org/title/Fzf#Arch_specific_fzf_uses
alias p="pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
alias pr="pacman -Qq | fzf --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns"
# Made by myself
alias y="yay -Slqa | fzf --multi --preview 'yay -Si {1}' | xargs -ro yay -S"

# Add a PROMPT_COMMAND to execute the function each time the prompt is displayed
# PROMPT_COMMAND="auto_activate_conda; $PROMPT_COMMAND"

# source /opt/esp-idf/export.sh


eval "$(thefuck --alias)"
uwufetch
