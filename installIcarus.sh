#!/bin/bash

source ${0%/*}/upkeep-shell.sh

OS=ARCH

cleanOS

updateOS
updatePip

#base install
installProgram "zsh nano zip sudo htop mc vlock gnupg git ntp python-pip"
setupSudo

#zsh
##make default shell
##sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

#ntp
##enable ntpd.service
#debian#enable ntp.service

installPip "ntfy"

installPip "thefuck"

#ssh(d) install
installProgram "openssh"
#debian#installProgram "ssh"
setupSsh
setupSshd

#laptop install
installProgram "tlp"
#tlp
##enable tlp.servie
##enable tlp-sleep.service
##disable systemd-rfkill.service

#active security install
installProgram "ufw clamav"
setupUfw
setupClamAv
##installProgram "firejail"

#audit security install
#removed chrootkit tripewire
installProgram "rkhunter lynis"
setupRkhunter
setuplynis
##installProgram "nmap sysstat"

#TOTP install
installProgram "qrencode libpam-google-authenticator"

#devel install
installProgram "base-devel"

#document install
installProgram "fbreader"

#media install
installProgram "mplayer fbi mpd"

#gui install
installProgram "xorg-server-utils xorg-xinit i3-wm i3status arandr lxappearance i3lock feh redshift terminator libnotify"
setupi3Status
setupi3Wm
setupi3Lock
setupFeh

#security gui install
#removed firetools
installProgram "gufw etherape kdeutils-kgpg"

#media gui install
installProgram "vlc"

#document gui install
installProgram "evince geany calibre"

#devel gui install
installProgram "qtcreator"
