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

# fcitx in all applications
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export SDL_IM_MODULE=fcitx
export INPUT_METHOD=fcitx

export PATH=$PATH:/home/cdmium/.local/bin:/home/cdmium/.local/bin/statusbar:/home/cdmium/.cargo/bin

# ENV for dwmblock-async
export TERMINAL=st
export EDITOR=vim

# fix matlab compatibility issue
export LD_PRELOAD=/lib64/libfreetype.so
export _JAVA_AWT_WM_NONREPARENTING=1
export AWT_TOOLKIT=MToolkit

# xxs-lock dim and lock time configuration
xset s 600 300
# xset dpms 900 900 900
xset -dpms
# xsecurelock behaviour
export XSECURELOCK_BLANK_DPMS_STATE=suspend
export XSECURELOCK_SHOW_DATETIME=1
export XSECURELOCK_DATETIME_FORMAT="%Y %b %d (%a) %H:%M:%S"
export XSECURELOCK_BLANK_TIMEOUT=10

# egui scale factor
export WINIT_X11_SCALE_FACTOR=1

xss-lock -n dim-screen.sh -- xsecurelock &
fcitx5 &
numlockx &
picom &
dwmblocks &

systemctl --user import-environment DISPLAY
clipmenud &

feh --bg-fill /usr/share/backgrounds/archlinux/wave.png

device=`xinput list | grep "Synaptics TM3276-031" | awk -F id= '{print $2}' | awk -F " " '{print $1}'`
natural=`xinput list-props $device | grep 'Natural Scrolling Enabled (' | awk -F"[()]" '{print $2}'` 
tap=`xinput list-props $device | grep 'Tapping Enabled (' | awk -F"[()]" '{print $2}'` 
click=`xinput list-props $device | grep 'Click Method Enabled (' | awk -F"[()]" '{print $2}'` 
xinput set-prop $device $natural 1 
xinput set-prop $device $tap 1 
xinput set-prop $device $click 0, 0
device=`xinput list | grep "Logitech G304" | grep pointer | awk -F id= '{print $2}' | awk -F " " '{print $1}'`
# coordinate=`xinput list-props $device | grep 'Coordinate Transformation Matrix (' | awk -F "[()]" '{print $2}'`
accel=`xinput list-props $device | grep 'Accel Speed (' | awk -F"[()]" '{print $2}'`
# xinput set-prop $device $coordinate 1, 0, 0, 0, 1, 0, 0, 0, 3
xinput set-prop $device $accel -1

exec dwm


