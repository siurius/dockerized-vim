#!/bin/bash

DVIM_FOLDER=.dockerized-vim
DVIM_HOME="/home/$USER"
[ ! -d "${HOME}/${DVIM_FOLDER}/" ] && mkdir -p ${HOME}/${DVIM_FOLDER}

# clone vimrc if not exist
if [ ! -d "${HOME}/${DVIM_FOLDER}/vimrc" ]; then
    VIMRC_FOLDER="${HOME}/${DVIM_FOLDER}/vimrc"
    git clone https://github.com/siurius/vimrc.git $VIMRC_FOLDER
    chmod -R 757 $VIMRC_FOLDER
fi

DVIM_FILE_PATH=""
if [ "$#" -ge 1 ]; then
    DVIM_FILE_PATH=/host$(readlink -f $1)
fi

# get current uid
REAL_UID=$(id -u)

# run docker
docker run --rm -it --hostname nvim -u $REAL_UID -e "HOME=$DVIM_HOME" \
    -v "/:/host" \
    -v "/etc/passwd:/etc/passwd:ro" -v "/etc/group:/etc/group:ro" \
    -v "${HOME}/${DVIM_FOLDER}:${DVIM_HOME}" \
    -w "/host/$PWD" \
    yiranli/dockerized-vim \
    $DVIM_FILE_PATH
