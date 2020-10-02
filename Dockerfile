# stage for ccls
FROM alpine:latest AS ccls
RUN apk add alpine-sdk cmake make clang clang-static clang-dev llvm-dev llvm-static \
	&& git clone --depth=1 --recursive https://github.com/MaskRay/ccls \
	&& cd ccls \
	&& cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release \
	&& cmake --build Release --target install

# final stage
FROM alpine:latest

MAINTAINER yiranli

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories

# prepare for vim and ccls
RUN apk add -U --no-cache \
    nodejs npm \
    git fzf ack \
    neovim neovim-doc \
    alpine-sdk clang llvm

# copy from previous stage
COPY --from=ccls /usr/local/bin/ccls /usr/local/bin/ccls

# install ccls and download vimrc
RUN cd /usr/share/ \
    && git clone https://github.com/siurius/vimrc.git \
    && chmod -R 757 vimrc \
    && echo 'let $VIMRC_DIR="/usr/share/vimrc"' >> /usr/share/nvim/sysinit.vim \
    && echo 'exec ":so " $VIMRC_DIR."/dotvimrc"' >> /usr/share/nvim/sysinit.vim \
    && chmod 757 /usr/share/nvim/sysinit.vim

RUN nvim -E -s -u /usr/share/nvim/sysinit.vim +PlugInstall +qall; return 0
RUN nvim -E -s -u /usr/share/nvim/sysinit.vim -c "CocInstall coc-java" +qall; return 0
RUN nvim -E -s -u /usr/share/nvim/sysinit.vim -c "CocInstall coc-snippets" +qall; return 0

ENTRYPOINT ["nvim"]
