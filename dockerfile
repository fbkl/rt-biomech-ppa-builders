FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    build-essential \
    catch2 \
    cmake \
    coinor-libipopt-dev \
    devscripts \
    dh-make \
    libmetis-dev \
    libmumps-dev \
    libsimbody-dev \
    libspdlog-dev \
    lintian \
    debhelper-compat \
    gnupg \
    git \
    fakeroot \
    sudo \
    wget \
    curl \
    vim \
    pkg-config \
    python3 \
    python3-pip \
    software-properties-common \
    sbuild debootstrap schroot

RUN add-apt-repository ppa:frkle/rt-biomech && \
    apt-get update && \
    apt-get install -y libsimbody-dev libsimbody3.7
# Optional: add a user for building (recommended over root)
RUN useradd -m builder && echo "builder ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN  sbuild-adduser builder
USER builder
WORKDIR /src


