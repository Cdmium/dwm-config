#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export SDL_IM_MODULE=fcitx
export INPUT_METHOD=fcitx

export PATH=$PATH:/home/cdmium/.local/bin:/home/cdmium/.local/bin/statusbar

export TERMINAL=st
export EDITOR=vim

xinput set-prop 'Synaptics TM3276-031' 337 1
xinput set-prop 'Synaptics TM3276-031' 360 1
xinput set-prop 'Synaptics TM3276-031' 370 0, 0
xinput set-prop 'pointer:Logitech G304' 213 1, 0, 0, 0, 1, 0, 0, 0, 2

fcitx5 &
numlockx &
picom &
dwmblocks &

feh --bg-fill /usr/share/backgrounds/archlinux/wave.png

exec dwm
