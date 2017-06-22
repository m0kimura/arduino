#!/bin/bash
#
  project=${PWD##*/}
##
  if [[ $1 = "build" ]] ; then
    if [[ ! -e $HOME/Arduino ]]; then
      mkdir $HOME/Arduino
    fi
    docker rm -f fx-${project}
    docker build -t ${project} --build-arg user=$USER .

    xhost +local:user
    docker run -d --name fx-${project} \
      --device=/dev/ttyUSB0 \
      -e DISPLAY=$DISPLAY \
      -e XMODIFIERS=$XMODIFIERS \
      -e XIMPROGRAM=$XIMPROGRAM \
      -e GTK_IM_MODULE=$GTK_IM_MODULE \
      -e QT_IM_MODULE=$QT_IM_MODULE \
      -e LC_TYPE=ja_JP.UTF-8 \
      -e TERM=xterm \
      -v /tmp/.X11-unix:/tmp/.X11-unix \
      -v $HOME/Arduino:/home/$USER/Arduino \
      -v /home/$USER \
      ${project}
  elif [[ $1 = "push" ]]; then
    if [[ S2 = "$null" ]]; then
      comment="update"
    else
      comment=$2
    fi
    dex push
    git add -A
    git commit -m "${comment}"
    git push
    exit
  elif [[ $1 = "stop" ]]; then
    docker stop fx-${project}
  else
    docker start fx-${project}
  fi
#

