#!/bin/bash

#secure-ssh.sh
#author jacob-greeley
#creates a new ssh user using $1 parameter
#adds a public key from the local repo or curled from the remote repo
#removes roots ability to ssh in
if [ -z "$1" ]; then
	echo "Usage: ./secure-ssh.sh <username>"
	exit 1
fi

USERNAME=$1


# Create user with home directory

sudo useradd -m -s /bin/bash "$USERNAME"

# Lock the Password

sudo passwd -l "$USERNAME"

# Create .ssh directory
#
sudo mkdir -p /home/$USERNAME/.ssh

# Set ownership
#

sudo chown -R $USERNAME:$USERNAME /home/$USERNAME/.ssh
#Set permissions
sudo chmod 700 /home/$USERNAME/.ssh

# Copy Public Key
#

sudo cp ~/SYS-265/linux/web01/id_rsa.pub /home/$USERNAME/.ssh/authorized_keys

# Set public key permissions
#

sudo chmod 600 /home/$USERNAME/.ssh/authorized_keys

# Set Ownership on auth keys
#
sudo chown $USERNAME:$USERNAME /home/$USERNAME/.ssh/authorized_keys

echo "User $USERNAME was created with SSH key authentication"


