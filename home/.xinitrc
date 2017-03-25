# export environment variables
export ABS="${HOME}/abs"
export CHROOT="${HOME}/chroot"
export CHROOT32="${HOME}/chroot32"
export XMODMAP="${HOME}/.xmodmap"
export XRESRC="${HOME}/.xresources"

# set X properties
[[ -f "${XRESRC}" ]] && xrdb -merge -I"${HOME}" "${XRESRC}"

# create directories if they don't already exist
[[ ! -d "${ABS}" ]] && mkdir "${ABS}"
[[ ! -d "${CHROOT}" ]] && mkdir "${CHROOT}"
[[ ! -d "${CHROOT32}" ]] && mkdir "${CHROOT32}"

# keymap helper functions
get_checksum() { md5sum "${XMODMAP}" | awk '{ print $1 }'; }
xmodmap_valid() { [[ -f "${XMODMAP}" ]] && [[ $(get_checksum) == "$1" ]] && return 0 || return 1; }
# assign variables with readonly property
declare -r PROC_INPUT="/proc/bus/input/devices"
declare -rA DEVICE=(['hhkb']="Topre Corporation HHKB Professional" 
                    ['chrm']="AT Translated Set 2 keyboard")
# determine if keyboard has a preferred map
HHKB_KEYBOARD=false && [[ $(grep -o "${DEVICE['hhkb']}" "${PROC_INPUT}") ]] && HHKB_KEYBOARD=true
CHRM_KEYBOARD=false && [[ $(grep -o "${DEVICE['chrm']}" "${PROC_INPUT}") ]] && CHRM_KEYBOARD=true
# md5sums for configs
HHKB_SUM="5e25b643ad2513ea149dd872a40e114a"
CHRM_SUM="259872dbb21a931bc1412d641114e1ae"
# xmodmap configurations
set_hhkb() { 
  cat > "${XMODMAP}" << EOF
keycode 102 = Super_L
keycode 100 = Super_R
keycode 119 = BackSpace
keycode 22  = Delete
EOF
}
set_chrm() { 
  cat > "${XMODMAP}" << EOF
keycode 133 = Super_L
keycode 68 = Next
keycode 67 = Prior
EOF
}
# set configs if keyboard w/ preferred map is present
! xmodmap_valid "${HHKB_SUM}" && [[ "${HHKB_KEYBOARD}" = true ]] && set_hhkb
! xmodmap_valid "${CHRM_SUM}" && [[ "${CHRM_KEYBOARD}" = true ]] && set_chrm
# map keys when necessary conditions are satisfied
[[ -f "${XMODMAP}" ]] && [[ "${HHKB_KEYBOARD}" = true || "${CHRM_KEYBOARD}" = true ]] && xmodmap "${XMODMAP}" 

#
autocutsel -fork &
autocutsel -selection PRIMARY -fork &
xscreensaver -nosplash &
pulseaudio --start
exec awesome
# vim: syntax=bash
