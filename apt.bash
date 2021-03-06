#!/bin/bash -x

# general

sudo apt update
sudo apt full-upgrade

sudo apt -y install - emacs-nox htop fail2ban logwatch git sysstat
sudo apt -y ssmtp mailutils

# pyend

sudo apt -y install make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl git gawk python-pip

# docker

sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common

sudo apt -y autoremove
sudo apt clean
