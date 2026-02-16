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


# Create user without password

sudo useradd -m -s /bin/bash "$USERNAME"

# Create .ssh directory for the user

sudo mkdir -p /home/$USERNAME/.ssh
sudo chmod 700 /home/$USERNAME/.ssh

# copy the pub key from web01 user's authorized_key

sudo touch /home/$USERNAME/.ssh/authorized_keys
sudo chmod 600 /home/$USERNAME/.ssh/authorized_keys

# Set proper ownership
sudo chown -R $USERNAME:$USERNAME /home/$USERNAME/.ssh

echo "User $USERNAME was created."

# Verify PermitRootLogin is disabled
echo ""
echo "Checking PermitLogin status:"
grep -i "PermitRootLogin" /etc/ssh/sshd_config


