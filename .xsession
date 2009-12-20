setxkbmap "us,ru" ",winkeys" "grp:shifts_toggle";
xmodmap ~/.xmodmap;
syndaemon &
nm-applet &
exec stumpwm 