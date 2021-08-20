#!/bin/sh

set -ex

export XAUTHORITY=$HOME/.Xauthority

cookie=`cat /tmp/.xauth/cookie`
echo add `hostname`/unix$DISPLAY . $cookie |xauth

cd $HOME

export XDG_CONFIG_HOME=$HOME

rsync -av /tmp/.zoom-tpl/ $HOME

eval "$@"
