
FROM docker.io/library/ubuntu:18.04@sha256:35082d7b7822aa397a787e3a4f3fba877cf4c39df625be21d40088603df056c0

SHELL ["/bin/bash", "-c"]

USER root
RUN dpkg --add-architecture i386 \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        alien                       \
        apt-transport-https         \
        build-essential             \
        ca-certificates             \
        checkinstall                \
        clang                       \
        cmake                       \
        curl                        \
        file                        \
        git                         \
        gnupg                       \
        lib32z1                     \
        libbz2-1.0:i386             \
        libc6:i386                  \
        libncurses5:i386            \
        libstdc++6:i386             \
        make                        \
        musl-dev                    \
        musl-tools                  \
        ninja-build                 \
        perl                        \
        pkg-config                  \
        pv                          \
        screen                      \
        software-properties-common  \
        sudo                        \
        time                        \
        unzip                       \
        vim                         \
        wget                        \
        xz-utils                    \
        zip                         \
    && \
    apt-get clean && \
    rm -rf /var/cache/apt/* && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/*

ARG USER_NAME=user
ARG USER_ID=1001
ARG USER_GID=1001

RUN : "adding user" && \
  set -x; \
  addgroup --gid ${USER_GID} ${USER_NAME} && \
  adduser --home /home/${USER_NAME} --disabled-password --shell /bin/bash --gid ${USER_GID} --uid ${USER_ID} --gecos '' ${USER_NAME} && \
  echo "%${USER_NAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ${USER_NAME}

WORKDIR /home/${USER_NAME}



