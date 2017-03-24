[[ -f ~/.xresources ]] && xrdb -merge -I$HOME ~/.xresources

# create directories if they don't already exist
[[ ! -d ~/chroot ]] && mkdir ~/chroot
[[ ! -d ~/chroot32 ]] && mkdir ~/chroot32

# helper functions
get_checksum() { return "$( md5sum ~/.xmodmap | awk '{ print $1 }' )"; }
xmodmap_exists() { [[ -f ~/.xmodmap && $( get_checksum ) == "$1" ]] && return 0 || return 1; }
# determine keyboard
HHKB_KEYBOARD=false && [[ $(grep -o "Topre Corporation HHKB Professional"  /proc/bus/input/devices) ]] && HHKB_KEYBOARD=true
CHRM_KEYBOARD=false && [[ $(grep -o "AT Translated Set 2 keyboard"  /proc/bus/input/devices) ]] && CHRM_KEYBOARD=true
# md5sums
HHKB_SUM="5e25b643ad2513ea149dd872a40e114a"
CHRM_SUM="259872dbb21a931bc1412d641114e1ae"
# xmodmap configurations
set_hhkb() { 
  cat > "${HOME}/.xmodmap" << EOF
keycode 102 = Super_L
keycode 100 = Super_R
keycode 119 = BackSpace
keycode 22  = Delete
EOF
}
set_chrm() { 
  cat > "${HOME}/.xmodmap" << EOF
keycode 133 = Super_L
keycode 68 = Next
keycode 67 = Prior
EOF
}
# set configs if necessary
[[ ${HHKB_KEYBOARD} && $( xmodmap_exists ${HHKB_SUM} ) != 0 ]] && set_hhkb
[[ ${CHRM_KEYBOARD} && $( xmodmap_exists ${CHRM_SUM} ) != 0 ]] && set_chrm
# remap keys
[[ -f ~/.xmodmap && ( ${HHKB_KEYBOARD} || ${CHRM_KEYBOARD} ) ]] && xmodmap ~/.xmodmap 

autocutsel -fork &
autocutsel -selection PRIMARY -fork &
xscreensaver -nosplash &
pulseaudio --start
exec awesome
