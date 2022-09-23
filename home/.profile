function genpasswd() {
  local passwd_len="${1}"
  local passwd_constraints=( "[A-Z]" "[a-z]" "[:punct:]" "[0-9]" )  # regenerate passwd until contains all constraints
  local newpasswd=""
  if [[ -z "${passwd_len}" ]]; then
    passwd_len=$(awk -v min=8 -v max=31 'BEGIN{srand(); print int(min+rand()*(max-min+1))}')
  fi
  if [[ "${passwd_len}" =~ ^([89]|[12][0-9]|3[0-1])$ ]]; then
    while [[ -z "${newpasswd}" ]]; do
      newpasswd="$(LC_CTYPE=C tr -dc '[:alnum:][:punct:]' < /dev/urandom | tr -cd '[:alnum:]_.-!@*?&$%' | head -c ${passwd_len})"
      for constraint in "${passwd_constraints[@]}"; do # check password requirements are met
  	if [[ -z "$(printf '%s' "${newpasswd}" | tr -cd "${constraint}")" ]]; then
          newpasswd="" # this constraint was not satisfied, do another iteration of while loop
          break
	fi
      done
    done
    printf "%s\n" "${newpasswd}"
  else 
    printf "genpasswd: positional arg 1 is non-empty or an int in [8,31]\n"
    return 1
  fi
}

function is_darwin() { [ "${OSTYPE:0:6}" = "darwin" ]; }
function is_linux() { [ "${OSTYPE:0:5}" = "linux" ]; }
# Prompt AWS
function sync_prompt() {
    is_darwin && {
        PS1="%n (${AWS_PROFILE:-default})%# "
    }
    is_linux && {
        BOLD="\[$(tput bold)\]"
        CYAN="\[$(tput setaf 6)\]"
        RESET="\[$(tput sgr0)\]"
        PS1="${RESET}${BOLD}[${CYAN}\u@\h \W${RESET}${BOLD}]${RESET}\$ "
    }
}
function profile() {
  profile_name="$1"
  if aws configure list-profiles | grep -s "$profile_name" &>/dev/null; then
    default_region="$(aws configure get region 2>/dev/null)"
    default_region="${default_region:-us-east-1}"
    profile_region="$(aws configure get region --profile "$profile_name" 2>/dev/null)"
    profile_region="${profile_region:-${default_region}}"
    export AWS_PROFILE="$profile_name"
    export AWS_REGION="$profile_region"
  fi
}
precmd_functions=(sync_prompt)

# Export
export ABS="${HOME}/abs"
export CHROOT="${HOME}/chroot"
export CHROOT32="${HOME}/chroot32"
export REPO="${HOME}/repo"

# in case not starting xorg, export env anyway
[[ -f "/usr/bin/vim" ]] && export VISUAL="vim" && export EDITOR="${VISUAL}"
is_linux && {
    export XMODMAP="${HOME}/.xmodmap"
    export XRESRC="${HOME}/.xresources"
    alias reboot="sudo systemctl reboot"
    alias poweroff="sudo systemctl poweroff"
    alias halt="sudo systemctl halt"
    
    alias build='arch-nspawn ${CHROOT}/root pacman -Syu; makechrootpkg -c -r ${CHROOT} -- -i'
    alias build32='arch-nspawn ${CHROOT32}/root pacman -Syu; makechrootpkg -c -r ${CHROOT32} -- -i'
    alias dirtybuild='arch-nspawn ${CHROOT}/root pacman -Syu; makechrootpkg -r ${CHROOT} -- -i'
    alias pkgcheck='shellcheck -e SC2034,SC2164,SC2154 -s bash'
    alias ls='ls --color=auto'
    alias newchroot='mkarchroot -C /etc/pacman.conf -M /etc/makepkg.conf $CHROOT/root base-devel archstrike-mirrorlist'
    alias tidy-xml='tidy -xml -i -m'
    alias run='arch-nspawn ${CHROOT}/${USER}'
    alias run32='arch-nspawn ${CHROOT32}/${USER}'
    alias runr='arch-nspawn ${CHROOT}/root'
    alias runr32='arch-nspawn ${CHROOT32}/root'
    alias clang-fsan='clang -O1 -g -fsanitize=address -fno-omit-frame-pointer -c'
    gpg-connect-agent updatestartuptty /bye >/dev/null
}
is_darwin && {
    # Assuming macOS ARM
    [[ "${PATH}" != *"homebrew/bin"* ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
    gpgconf --launch gpg-agent
}

export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
eval "$(pyenv init --path)"
