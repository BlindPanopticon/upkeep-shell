function updateArchPacman {
	writeLogEntry "pacman" "update" "started"
	
	pacman -Syu
	
	writeLogEntry "pacman" "update" "ended"
}

function updateDebianAptGet {
	writeLogEntry "apt-get" "update" "started"
	
	apt-get update
	apt-get upgrade
	
	writeLogEntry "apt-get" "update" "ended"
}

function updateOS {
	case $OS in
		"ARCH")
			updateArchPacman;;
		"DEBIAN")
			updateDebianAptGet;;
		*)
			writeLogEntry "operating system" "update" "failed; invalid OS"
	esac
}

###########################################################################

function updatePip {
	writeLogEntry "pip" "update" "started"
	
	pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U
	
	writeLogEntry "pip" "update" "ended"
}

function installPip {
	writeLogEntry "pip" "install" "started;$1"
	
	pip install $1
	
	writeLogEntry "pip" "install" "ended;$1"
}

###########################################################################

function installArchPacman {
	writeLogEntry "pacman" "install" "started;$1"
	
	pacman -Syy
	pacman -S $1
	
	writeLogEntry "pacman" "install" "ended;$1"
}

function installDebianAptGet {
	writeLogEntry "apt-get" "install" "started;$1"
	
	apt-get update
	apt-get install "$1"
	
	writeLogEntry "apt-get" "install" "ended;$1"
}

function installProgram {
	case $OS in
		"ARCH")
			installArchPacman "$1";;
		"DEBIAN")
			installDebianAptGet "$1";;
		*)
			writeLogEntry "operating system" "install" "failed; invalid OS"
	esac
}

###########################################################################

function cleanArchPacman {
	writeLogEntry "pacman" "clean" "started"
	
	LIST=$(pacman -Qdtq)
	if [ $? -eq 0 ]
	then
		pacman -Rs $LIST
	fi
	
	pacman -Scq
	
	writeLogEntry "pacman" "clean" "ended"
}

function cleanDebianAptGet {
	writeLogEntry "apt-get" "clean" "started"
	
	apt-get autoremove
	apt-get autoclean
	
	writeLogEntry "apt-get" "clean" "ended"
}

function cleanOS {
	case $OS in
		"ARCH")
			cleanArchPacman;;
		"DEBIAN")
			cleanDebianAptGet;;
		*)
			writeLogEntry "operating system" "clean" "failed; invalid OS"
	esac
}
