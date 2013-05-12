export LANG=zh_CN.UTF-8
#export LC_ALL="zh_CN.UTF-8"

#export GTK_IM_MODULE=ibus
#export XMODIFIERS=@im=ibus
#export QT_IM_MODULE=ibus
#export XIM=ibus
#export XIM_PROGRAM=ibus

export GTK_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export QT_IM_MODULE=fcitx
export XIM=fcitx
export XIM_PROGRAM=fcitx
fcitx -d & 

xrdb .Xresouces &

#stalonetray -p &

#exec i3
#exec fvwm
#exec musca
exec openbox-session
#exec mate-session
