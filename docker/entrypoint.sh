#!/bin/bash -e

USER_ID=$(id -u)
GROUP_ID=$(id -g)

# create group
if [ x"$GROUP_ID" != x"0" ]; then
    groupadd -g $GROUP_ID $USER_NAME
fi

# add user
if [ x"$USER_ID" != x"0" ]; then
    useradd -d /home/$USER_NAME -m -s /bin/bash -u $USER_ID -g $GROUP_ID $USER_NAME
fi

# revert permission
sudo chmod u-s /usr/sbin/useradd
sudo chmod u-s /usr/sbin/groupadd

# If you want to install the package after build
sudo gpasswd -a docker sudo
# sudo chown -R docker:docker /.pyenv

# alias
echo "alias ll='ls -larth'" >> /home/docker/.bashrc
echo "alias rm='rm -rf'" >> /home/docker/.bashrc
echo "alias cp='cp -r'" >> /home/docker/.bashrc
echo "alias mkdir='mkdir -p'" >> /home/docker/.bashrc
echo "alias less='less -NS'" >> /home/docker/.bashrc

exec $@
