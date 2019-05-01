#!/bin/bash

echo -n "Email : "
read email
echo -n "Name  : "
read name

# create swap if not present

swap=/swapfile

if [ ! -f $swap ]; then
   sudo fallocate -l 1G $swap
   sudo chmod 600 $swap
   sudo mkswap $swap
   sudo swapon /swapfile
   echo '/swapfile swap swap defaults 0 0' | sudo tee -a /etc/fstab
   cat /etc/fstab
   sudo swapon --show
   echo 'Press <RETURN>'
   read a
fi

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

. ~/.bash_profile

# add emacs init.el

if [ ! -d ~/.emacs ]; then
    mkdir ~/.emacs
fi

if [ ! -f ~/.emacs/init.el ]; then
    ln ~/setup/init.el ~/.emacs/init.el
fi

if [ ! -f ~/.ssh/id_rsa ]; then
    ssh-keygen -t rsa -b 4096 -C "$email"
    ls -l ~/.ssh/
    cat  ~/.ssh/id_rsa.pub
    echo 'Add to GitHub then press <RETURN>'
    read a    
fi

. apt.bash

# git 

git config --global user.email "$email"
git config --global user.name  "$name"

# pyenv

if [ ! -d ~/.pyenv/ ]; then
  git clone https://github.com/pyenv/pyenv.git ~/.pyenv
  pyenv install 3.7.2
  pyenv rehash
  pyenv global 3.7.2
fi

# docker

# pip install docker-compose

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

if [ ! -f /etc/apt/sources.list.d/docker.list ]; then
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
  sudo apt-get update
  sudo apt-get -y install docker-ce docker-ce-cli containerd.io
fi

sudo docker run hello-world

if [ ! -f /etc/docker/daemon.json ]; then
   sudo cp daemon.json /etc/docker/daemon.json
fi

cat /etc/docker/daemon.json
