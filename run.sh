#!/bin/bash

DVIM_FOLDER=.dockerized-vim
DVIM_HOME="/home/$USER"
[ ! -d "${HOME}/${DVIM_FOLDER}/" ] && mkdir -p ${HOME}/${DVIM_FOLDER}
DVIM_FILE_PATH=""
if [ "$#" -ge 1 ]; then
    DVIM_FILE_PATH=/host$(readlink -f $1)
fi

# run docker
docker run --rm -it --hostname nvim -u $(id -u) -e "HOME=$DVIM_HOME" \
    -v "/:/host" \
    -v "/etc/passwd:/etc/passwd:ro" -v "/etc/group:/etc/group:ro" \
    -v "${HOME}/${DVIM_FOLDER}:${DVIM_HOME}" \
    -w "/host/$PWD" \
    yiranli/dockerized-vim \
    $DVIM_FILE_PATH
