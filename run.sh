docker run --rm -it --hostname nvim -u $(id -u) -e "HOME=$HOME" -v "$PWD:$HOME/source/" yiranli/dockerized-vim
