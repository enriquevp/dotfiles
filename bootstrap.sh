#!/usr/bin/env bash
# Installs packages and copies over configurations file, for a new Fedora installation.
# Shamelessly copied parts from Jessie Frazelle's script.

set -e


check_if_sudo() {
    if [ "$EUID" -ne 0 ]; then
        echo "Please run as root."
        exit
    fi
}

setup_passwordless_sudo() {
    local USERNAME="enrique"

    usermod -aG wheel $USERNAME

    gpasswd -a $USERNAME systemd-journal
    gpasswd -a $USERNAME systemd-network

    echo -e "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
    echo -e "Passwordless sudo now setup."
}

setup_dnf_repos() {
    dnf copr enable yaroslav/i3desktop
    echo -e "Extra repositories now setup."
}

setup_fonts() {
    curl https://gist.github.com/epegzz/1634235/raw/4691e901750591f9cab0b4ae8b7c0731ebf28cce/Monaco_Linux-Powerline.ttf -o ~/.fonts/MonacoPowerline.ttf


    fc-cache -fv
    echo -e "Fonts now setup."
}

setup_wm() {
    local pkgs=( i3 compton rofi scrot feh )
    dnf install -y ${pkgs[@]}

    echo -e "Window manager now installed. "
    echo -e "Please symlink your config now. "

}

install_pkgs() {
    dnf update -y
    dnf install -y $(cat pkglist)

    dnf install -y tlp tlp-rdw
}

setup_dotfiles() {
    curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -o ~/.git-prompt.sh

    for program in $(ls -d */); do
        program=${program%%/}
        stow $program 
        if [[ $? -eq 0 ]]; then
            echo -e "\nSuccessfully symlinked dotfile(s) for $program"
        fi
    done

}

usage() {
	echo -e "install.sh\n\tThis script sets up a new Fedora install\n"
	echo "Usage:"
	echo "  dotfiles                    - get dotfiles"
	echo "  fonts                       - setup fonts"
	echo "  pkgs                        - setup extra repos & install pkgs"
	echo "  wm                          - install window manager/desktop pkgs"
	echo "  sudo                        - sets up passwordless sudo"
}

main() {
	local cmd=$1

	if [[ -z "$cmd" ]]; then
		usage
		exit 1
	fi


	if [[ $cmd == "pkgs" ]]; then
		check_if_sudo

    setup_dnf_repos
		install_pkgs

	elif [[ $cmd == "wm" ]]; then
		check_if_sudo
		setup_wm

	elif [[ $cmd == "dotfiles" ]]; then
		setup_dotfiles

	elif [[ $cmd == "fonts" ]]; then
		  setup_fonts

	elif [[ $cmd == "sudo" ]]; then
    check_if_sudo
    setup_passwordless_sudo

	else
		usage
	fi
}

main "$@"
