#!/bin/bash

DVIM_VIM_FOLDER=.dockerized-vim/vim
DVIM_LOCAL_FOLDER=.dockerized-vim/local
DVIM_CONFIG_FOLDER=.dockerized-vim/config
[ ! -d "${HOME}/${DVIM_VIM_FOLDER}/" ] && mkdir -p ${HOME}/${DVIM_VIM_FOLDER}
[ ! -d "${HOME}/${DVIM_LOCAL_FOLDER}/" ] && mkdir -p ${HOME}/${DVIM_LOCAL_FOLDER}
[ ! -d "${HOME}/${DVIM_CONFIG_FOLDER}/" ] && mkdir -p ${HOME}/${DVIM_CONFIG_FOLDER}

# run docker
docker run --rm -it --hostname nvim -u $(id -u) -e "HOME=$HOME" \
    -v "/:/host" \
    -v "/etc/passwd:/etc/passwd:ro" -v "/etc/group:/etc/group:ro" \
    -v "${HOME}/${DVIM_VIM_FOLDER}:${HOME}/.vim" \
    -v "${HOME}/${DVIM_LOCAL_FOLDER}:${HOME}/.local" \
    -v "${HOME}/${DVIM_CONFIG_FOLDER}:${HOME}/.config" \
    -w "/host/$PWD" \
    yiranli/dockerized-vim \
    "$@"
