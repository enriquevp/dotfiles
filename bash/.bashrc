# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
source ~/.git-prompt.sh
export PS1="\n\[\033[38;5;1m\]\u\[$(tput sgr0)\] at \[$(tput sgr0)\]\[\033[38;5;3m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\]$(tput sgr0) in \[$(tput sgr0)\]\[\033[38;5;39m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]\$(__git_ps1)$(tput sgr0)\n$ "

