#!/bin/sh

set -ex

env
xauth list
hostname

cookie=`cat /tmp/.xauth/cookie`
echo add `hostname`/unix$DISPLAY . $cookie |xauth

echo
xauth list

cd $HOME

pwd
ls -al

export XDG_CONFIG_HOME=/home/w

eval "$@"
