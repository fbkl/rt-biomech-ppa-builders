FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    software-properties-common 

RUN add-apt-repository ppa:frkle/rt-biomech && \
    apt-get update && \
    apt-get install -y \
    libsimbody-dev \
    libsimbody3.7 \
    catch2 \
    build-essential \
    cmake \
    coinor-libipopt-dev \
    devscripts \
    dh-make \
    libmetis-dev \
    libmumps-dev \
    libspdlog1 \
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
    sbuild debootstrap schroot

# Optional: add a user for building (recommended over root)
RUN useradd -m builder && echo "builder ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN  sbuild-adduser builder
USER builder
WORKDIR /src


