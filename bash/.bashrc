#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias run='arch-nspawn ${CHROOT}/${USER}'
alias run32='arch-nspawn ${CHROOT32}/${USER}'
alias runr='arch-nspawn ${CHROOT}/root'
alias runr32='arch-nspawn ${CHROOT32}/root'
alias build='arch-nspawn ${CHROOT}/root pacman -Syu; makechrootpkg -c -r ${CHROOT} -- -i'
alias build32='arch-nspawn ${CHROOT32}/root pacman -Syu; makechrootpkg -c -r ${CHROOT32} -- -i'

PS1='[\u@\h \W]\$ '
[ -n "${XTERM_VERSION}" ] && transset-df --id "${WINDOWID}" > /dev/null
[ -d "/home/$(whoami)/bin" ] && PATH=${PATH}:~/bin
export CHROOT="${HOME}/chroot"
export CHROOT32="${HOME}/chroot32"

source /usr/share/git/completion/git-completion.bash
