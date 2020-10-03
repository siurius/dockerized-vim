#!/bin/bash

DVIM_FOLDER=.dockerized-vim
[ ! -d "${HOME}/${DVIM_FOLDER}/" ] && mkdir -p ${HOME}/${DVIM_FOLDER}

# run docker
docker run --rm -it --hostname nvim -u $(id -u) -e "HOME=$HOME" \
    -v "/:/host" \
    -v "/etc/passwd:/etc/passwd:ro" -v "/etc/group:/etc/group:ro" \
    -v "${HOME}/${DVIM_FOLDER}:${HOME}" \
    -w "/host/$PWD" \
    yiranli/dockerized-vim \
    "$@"
