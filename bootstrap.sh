#!/usr/bin/env bash
# Installs packages and copies over configurations file, for a new Fedora installation.
# Shamelessly copied parts from Jessie Frazelle's script.

set -e

USERNAME=$(whoami)

check_if_sudo() {
    if [ "$EUID" -ne 0]; then
        echo "Please run as root."
        exit
    fi
}

setup_dnf_repos() {
    dnf copr enable yaroslav/i3desktop

}

install_pkgs() {
    dnf update -y
    dnf install -y $(cat pkglist)

    dnf install -y tlp tlp-rdw
}

symlink_conf() {
    su enrique
    curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -o ~/.git-prompt.sh

    for program in $(ls); do
        stow $program
        if [[ $? -eq 0 ]]; then
            echo "Successfully symlinked dotfile(s) for $program"
        fi
    done

}
