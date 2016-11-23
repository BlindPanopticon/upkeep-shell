function setupi3Wm {
	writeLogEntry "i3wm" "setup" "started"
	#TODO
	
	gitClone https://github.com/BlindPanopticon/config-files.git
	#choose and symlink config

	writeLogEntry "i3wm" "setup" "ended"
	}
	
function setupi3Status {
	writeLogEntry "i3status" "setup" "started"
	#TODO
	
	gitClone https://github.com/BlindPanopticon/config-files.git
	#choose and symlink config

	writeLogEntry "i3status" "setup" "ended"
	}
	
function setupi3Lock {
	writeLogEntry "i3lock" "setup" "started"
	#TODO
	
	#add to startup via 

	writeLogEntry "i3lock" "setup" "ended"
	}
	
function setupFeh {
	writeLogEntry "feh" "setup" "started"
	#TODO
	
	#deploy feh wallpaper
	#add to startup
##make/choose wallpaper folder

	writeLogEntry "feh" "setup" "ended"
	}
	
function setupRedshift {
	writeLogEntry "redshift" "setup" "started"
	#TODO
	
	#deploy redshift
##set location
#add to startup

	writeLogEntry "redshift" "setup" "ended"
	}
