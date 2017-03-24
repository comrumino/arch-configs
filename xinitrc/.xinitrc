[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap
[[ ! -e ~/chroot ]] && mkdir ~/chroot
[[ ! -e ~/chroot32 ]] && mkdir ~/chroot32
autocutsel -fork &
autocutsel -selection PRIMARY -fork &
xscreensaver -nosplash &
pulseaudio --start
exec awesome
