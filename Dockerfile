FROM alpine:latest

MAINTAINER yiranli

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories

RUN apk add -U --no-cache \
    git neovim

ENTRYPOINT ["nvim"]
