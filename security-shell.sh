function setupSudo {
	writeLogEntry "sudo" "setup" "started"
	#TODO
	
##add wheel group
##ask for main sudoer user
##make user
##add user to wheel
	gpasswd -a $USER wheel
##disable login as root
	passwd -l root
##remove root password
	sed root:*: root:!:
##su to to user
	su $USER
	writeLogEntry "sudo" "setup" "ended"
	}

###########################################################################

function setupGoogleAuth {
	writeLogEntry "google-auth" "setup" "started"
	
	google-authenticator
	
	PS3='Please select a google-auth target to deploy: '
	options=("SSH" "Login" "Done")
	select opt in "${options[@]}"
	do
		case $opt in
			"SSH")
				deploySshGoogleAuth
				;;
			"Login")
				deployLoginGoogleAuth
				;;
			"Done")
				break
				;;
			*) echo invalid option;;
		esac
	done
	
	writeLogEntry "google-auth" "setup" "ended"
	}

function deploySshGoogleAuth {
	writeLogEntry "google-auth" "ssh setup" "started"
	#TODO
	
	##ask yes sshd
###add as required to pam.d sshd
###challengeresponse yes to sshd config
	
	writeLogEntry "google-auth" "ssh setup" "ended"
	}

function deployLoginGoogleAuth {
	writeLogEntry "google-auth" "login setup" "started"
	#TODO
	
	##ask yes login
###add to pam.d login
	#echo 'auth required pam_google_authenticator.so' >> /etc/pam.d/login
	
	writeLogEntry "google-auth" "login setup" "ended"
	}
	
###########################################################################
	
function setupUfw {
	writeLogEntry "ufw" "setup" "started"

	ufw default deny

	systemctl status sshd.socket | grep '; enabled;'
	if [ $? -ne 0 ]; then
		ufw allow SSH
	fi

	enableService ufw.service
	
	ufw enable

	writeLogEntry "ufw" "setup" "ended"
	}
	
###########################################################################

function setupClamAv {
	writeLogEntry "clamav" "setup" "started"
	
	updateClamAv
	enableServicesClamAv
	scanClamAv "/home"
	
	ln -s /var/log/clamav/freshclam.log ${0%/*}/log/freshclam.log
	
	writeLogEntry "clamav" "setup" "ended"
	}

function updateClamAv {
	writeLogEntry "clamav" "update" "started"
	
	freshclam
	
	writeLogEntry "clamav" "update" "ended"
	}

function enableServicesClamAv {
	writeLogEntry "clamav" "enable services" "started"
	
	enableService freshclamd.service
	enableService clamd.service
	
	writeLogEntry "clamav" "enable services" "ended"
	}

function scanClamAv {
	writeLogEntry "clamav" "scan" "started;$1"
	
	AVLOG="${0%/*}/log/clamav.log"
	clamscan -l $AVLOG -r -i $1
	
	writeLogEntry "clamav" "scan" "ended;$1"	
	}
	
###########################################################################

function setupRkhunter {
	writeLogEntry "rkhunter" "setup" "started"
	
	updateRkhunter
	trustRkhunter
	scanRkhunter
	
	ln -s /var/log/rkhunter.log ${0%/*}/log/rkhunter.log
	
	writeLogEntry "rkhunter" "setup" "ended"
	}

function updateRkhunter {
	writeLogEntry "rkhunter" "update" "started"
	
	rkhunter --update
	
	writeLogEntry "rkhunter" "update" "ended"	
	}

function trustRkhunter {
	writeLogEntry "rkhunter" "trust" "started"
	
	rkhunter --propupd
	
	writeLogEntry "rkhunter" "trust" "ended"	
	}

function scanRkhunter {
	writeLogEntry "rkhunter" "scan" "started"
	
	rkhunter --check
	
	writeLogEntry "rkhunter" "scan" "ended"	
	}
	
###########################################################################

function setupLynis {
	writeLogEntry "lynis" "setup" "started"
	#TODO
	
	writeLogEntry "lynis" "setup" "ended"
	}
	
###########################################################################

function setupSshd {
	writeLogEntry "sshd" "setup" "started"
	#TODO
	
	##add only current user to allowedusers
	AllowUsers $USER >> /etc/ssh/sshd_config
##set sshd to protocol 2
##set sshd no root permmited
	sed "permitRootLogin *\n" "permitRootLogin no"

	enableService sshd.socket
	#debian#enableService ssh.socket

	writeLogEntry "sshd" "setup" "ended"
	}
	
function setupSsh {
	writeLogEntry "ssh" "setup" "started"
	#TODO
	
	#openssh	https://wiki.archlinux.org/index.php/Ssh
	
	gitClone https://github.com/BlindPanopticon/ssh.git

	FILES=~/git/ssh/*.pub
	for f in $FILES
	do
		cat $f >> ~/.ssh/authorized_keys
	done

	ssh-keygen -C "$(whoami)@$(hostname)-$(date -I)"

###provide public key for deployment to github

	cp ~/.ssh/id_rsa.pub ~/git/ssh/$HOST.pub

###ssh push ssh public keys

	writeLogEntry "ssh" "setup" "ended"
	}
