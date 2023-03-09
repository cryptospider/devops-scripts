#!/bin/bash

# Script installs gitlab-runner

# Check root permission
SUDO=
if [ "$UID" != "0" ]; then
	if [ -e /usr/bin/sudo -o -e /bin/sudo ]; then
		SUDO=sudo
	else
		echo '*** This quick installer script requires root privileges.'
		exit 0
	fi
fi

curl -fsSL https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh | $SUDO bash


$SUDO apt install gitlab-runner

# Set values for --url, --registration-token, --description, --tag-list

$SUDO gitlab-runner register -n --url https://gitlab.com/ --registration-token GR1348941Gs7_dBRozhpVuZLtZQsi --executor docker --description "Development Runner" --docker-image "docker:stable" --tag-list development --docker-privileged

$SUDO systemctl enable gitlab-runner