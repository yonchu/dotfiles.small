#
#  .zlogin
#

typeset -U manpath
manpath=(/usr/*/man(N-/) /usr/local/*/man(N-/) /var/*man(N-/))
manpath=(/usr/local/share/man /opt/local/share/man /usr/local/jman $manpath)
export MANPATH


### Complete Messages
echo "Loading .zlogin completed!!"

