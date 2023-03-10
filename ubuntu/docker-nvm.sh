#!/bin/bash

# Script installs docker and node version manager (nvm)
# Run program with curl:  curl -s https://raw.githubusercontent.com/cryptospider/devops-scripts/main/ubuntu/docker-nvm.sh | sudo bash

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

# Update package index
$SUDO apt-get update

# Upgrade packages
# $SUDO apt-get upgrade

# Uninstall old versions
$SUDO apt-get remove docker docker-engine docker.io containerd runc

# Install packages
$SUDO apt-get install ca-certificates curl gnupg lsb-release

# Add Docker’s official GPG key
$SUDO mkdir -m 0755 -p /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | $SUDO gpg --dearmor -o /etc/apt/keyrings/docker.gpg

$SUDO chmod a+r /etc/apt/keyrings/docker.gpg

# Setup repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package index
$SUDO apt-get update

# Install latest version of docker
$SUDO apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Create docker group
$SUDO groupadd docker

# Add current user to docker group
$SUDO usermod -aG docker $USER

# Instal node version manager
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

# Add nvm to path
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Install node version
# Eg: nvm install 14.10.0