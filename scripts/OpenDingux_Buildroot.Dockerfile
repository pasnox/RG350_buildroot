FROM ubuntu:16.04

WORKDIR /work

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get dist-upgrade -y

# Require perl <= 5.22 for automake
RUN apt-get install -y --no-install-recommends \
    ca-certificates \
    sudo \
    apt-utils \
    man-db \
    build-essential \
    gcc-multilib \
    gettext \
    ncurses-dev \
    help2man \
    nano \
    rsync \
    wget \
    cpio \
    python3 \
    zip \
    unzip \
    bc \
    git \
    mercurial \
    subversion \
    squashfs-tools && \
    apt-get -qq clean

# RUN adduser --disabled-password --gecos '' docker
# RUN adduser docker sudo
# RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Match dingux user with system user which is gid 1000 / uid 1000 most of the time
RUN addgroup --gid 1000 dingux && \
    adduser --no-create-home --ingroup dingux --uid 1000 dingux && \
    usermod -a -G users dingux && \
    usermod -a -G sudo dingux

RUN mkdir -p /work/OpenDingux_Buildroot
