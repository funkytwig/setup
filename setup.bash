#!/bin/bash

# create swap if not present

swap=/swapfile

if [ ! -f $swap ]
   sudo fallocate -l 1G $swap
   sudo chmod 600 $swap
   sudo mkswap $swap
   sudo swapon /swapfile
   sudo echo '/swapfile swap swap defaults 0 0' >> /etc/fstab
fi

exit

# add to ~/.bashrc if needed

grep -Fq ". ~/setup/bash.inc" ~/.bashrc
if [ $? -eq 1 ]
then	
    echo "add it .bashrc"
    printf '\n\n. ~/setup/bash.inc\n' >> ~/.bashrc
fi

# add to ~/.bash_profile if needed

if [ -f ~/.bash_profile ]
then
  grep -Fq ". ~/setup/bash.inc" ~/.bash_profile
  if [ $? -eq 1 ]
  then
      echo "add it .bash_profilile"
      printf '\n\n. ~/setup/bash.inc\n' >> ~/.bash_profile
  fi
else
    printf '\n\n. ~/setup/bash.inc\n' >> ~/.bash_profile
fi

# add emacs init.el

if [ ! -d ~/.emacs ]; then
    mkdir ~/.emacs
fi

if { ! -f ~/.emacs/init.el ]; then
    ln -s init.el ~/.emacs/init.el
fi

. apt.bash

# git 

git config --global user.email "bene@funkytwig.com"
git config --global user.name "Ben Edwards"

# pyenv

git clone https://github.com/pyenv/pyenv.git ~/.pyenv

. ~/..bash_profile

pyenv install 3.7.2
pyenv rehash
pyenv global 3.7.2

# docker

pip install docker-compose

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io

sudo docker run hello-world

if [ ! -f /etc/docker/daemon.json ]; then
   sudo cp daemon.json /etc/docker/daemon.json
fi

cat /etc/docker/daemon.json
