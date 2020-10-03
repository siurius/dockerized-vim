#!/bin/bash

DVIM_FOLDER=.dockerized-vim
DVIM_HOME="/home/$USER"
[ ! -d "${HOME}/${DVIM_FOLDER}/" ] && mkdir -p ${HOME}/${DVIM_FOLDER}

# run docker
docker run --rm -it --hostname nvim -u $(id -u) -e "HOME=$DVIN_HOME" \
    -v "/:/host" \
    -v "/etc/passwd:/etc/passwd:ro" -v "/etc/group:/etc/group:ro" \
    -v "${HOME}/${DVIM_FOLDER}:${DVIM_HOME}" \
    -w "/host/$PWD" \
    yiranli/dockerized-vim \
    "$@"
