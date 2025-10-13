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
    python3 \
    python3-pip

# Optional: add a user for building (recommended over root)
RUN useradd -m builder && echo "builder ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
USER builder
WORKDIR /home/builder


