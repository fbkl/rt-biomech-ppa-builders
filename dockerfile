ARG BASE_IMAGE=ubuntu:20.04
ARG BASE_DISTRO_NAME=focal
FROM ${BASE_IMAGE} AS base
ARG BASE_DISTRO_NAME
ARG BASE_IMAGE
ENV BASE_DISTRO_NAME=${BASE_DISTRO_NAME}

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y \
    build-essential \
    cmake \
    devscripts \
    dh-make \
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
    lintian \
    sbuild debootstrap schroot debhelper-compat \
    software-properties-common 
##TODO: add freaking stages to build and then it is easier to maintain this

RUN useradd -m ${BASE_DISTRO_NAME}builder && echo "${BASE_DISTRO_NAME}builder ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN  sbuild-adduser ${BASE_DISTRO_NAME}builder
USER ${BASE_DISTRO_NAME}builder
ADD maintainer_info /etc/environment
WORKDIR /src

ARG BASE_IMAGE
ARG BASE_DISTRO_NAME
FROM base AS deps
ARG BASE_DISTRO_NAME
ARG BASE_IMAGE
ENV BASE_DISTRO_NAME=${BASE_DISTRO_NAME}
USER root

RUN add-apt-repository ppa:frkle/rt-biomech && \
    apt-get update && \
    apt-get install -y \
    coinor-libipopt-dev \
    libmetis-dev \
    libmumps-dev \
    liblapack-dev libblas-dev libgl1-mesa-dev libglu1-mesa-dev freeglut3-dev libxi-dev libxmu-dev \
    libsimbody-dev \
    libsimbody3.7 \
    catch2 \
    libspdlog1 \
    libspdlog-dev 

USER ${BASE_DISTRO_NAME}builder
WORKDIR /src


