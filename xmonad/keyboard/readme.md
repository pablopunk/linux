### Create file /etc/modprobe.d/hid_apple.conf to change the F1~F12 behavior:

options hid_apple fnmode=2

### Add these lines to ~/.Xmodmap to swap the command and control key:

remove mod4 = Super_L Super_R
remove control = Control_L

add control = Control_L
add control = Super_L Super_R

### Install fcitx-im and start it in ~/.xinitrc:

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
fcitx &
