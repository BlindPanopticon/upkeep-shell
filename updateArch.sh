#!/bin/bash

source ${0%/*}/upkeep-shell.sh

OS=ARCH

cleanOS

updateOS
updatePip

updateClamAv
scanClamAv "/home"

updateRkhunter
scanRkhunter
