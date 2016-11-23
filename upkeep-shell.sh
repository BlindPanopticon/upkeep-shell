#setup hostname value
HOST=$(uname -n)
#setup 64/86 bit architecture value
ARCH=$(uname -m)
#setuo log file
LOGFILE="${0%/*}/log/$HOST.log"

mkdir "${0%/*}/log"

function writeLogEntry {
	TIME=$(date --rfc-3339=seconds)
	DATA="$TIME : $1 : $2 : $3"
	
	if [ $? -ne 0 ]; then
		DATA="$TIME : $1 : $2 : $3 : ERROR;$?"
	fi
	
	writeTerminalStatement "$DATA"
	
	echo $DATA >> $LOGFILE
}

function writeTerminalStatement {
	echo $1
}

###########################################################################

function confirmCommand {
	read -n1 -p "Confirm run command '$1' (y/N): "
	case $REPLY in
		Y | y) 
			$1
			;;
		* ) ;;
	esac
}

function enableService {
	writeLogEntry "service" "enable" "started;$1"
	
	systemctl status $1 | grep '; enabled;'
	
	if [ $? -eq 0 ]; then
		systemctl enable $1
		systemctl restart $1
	fi
	
	writeLogEntry "service" "enable" "ended;$1"
	}

function gitClone {
	writeLogEntry "git" "clone" "started;$1"
	
	DIR=$(pwd)
	
	#assumes that this script is running in ~/git/upkeep-shell
	cd ..
	git clone $1
	cd "$DIR"
	
	writeLogEntry "git" "clone" "ended;$1"
}

source ${0%/*}/package-shell.sh
source ${0%/*}/security-shell.sh
source ${0%/*}/x-shell.sh
