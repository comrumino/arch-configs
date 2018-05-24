#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias reboot="sudo systemctl reboot"
alias poweroff="sudo systemctl poweroff"
alias halt="sudo systemctl halt"

alias build='arch-nspawn ${CHROOT}/root pacman -Syu; makechrootpkg -c -r ${CHROOT} -- -i'
alias build32='arch-nspawn ${CHROOT32}/root pacman -Syu; makechrootpkg -c -r ${CHROOT32} -- -i'
alias ls='ls --color=auto'
alias tidy-xml='tidy -xml -i -m'
alias run='arch-nspawn ${CHROOT}/${USER}'
alias run32='arch-nspawn ${CHROOT32}/${USER}'
alias runr='arch-nspawn ${CHROOT}/root'
alias runr32='arch-nspawn ${CHROOT32}/root'

PS1='[\u@\h \W]\$ '
[[ -n "${XTERM_VERSION}" ]] && transset-df --id "${WINDOWID}" > /dev/null
[[ -d "/home/$(whoami)/bin" ]] && PATH=${PATH}:~/bin

# Configure git bash completion and editor selection
GIT_BC="/usr/share/git/completion/git-completion.bash"
[[ -f ${GIT_BC} ]] && source ${GIT_BC}
[[ -f "/usr/bin/vim" ]] && export VISUAL="vim" && export EDITOR="${VISUAL}"

[[ -f "/usr/bin/vmware" ]] && export VMWARE_USE_SHIPPED_LIBS='yes'
