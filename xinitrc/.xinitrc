[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap
autocutsel -fork &
autocutsel -selection PRIMARY -fork &
xscreensaver -nosplash &
pulseaudio --start
exec awesome
