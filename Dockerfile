FROM ubuntu:24.04

ARG BUILD_DATE
ARG DEBIAN_FRONTEND=noninteractive
ARG USERNAME=devuser
ARG USER_UID=1001
ARG USER_GID=1001
ARG EMAIL="dev@example.com"

# Metadata
LABEL maintainer=$EMAIL
LABEL org.label-schema.build-date=$BUILD_DATE
LABEL description="Lightweight Ubuntu dev environment with zsh, sudo, and common tools"

# Install dependencies, create user, and set up basic environment in one layer
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        sudo \
        curl \
        wget \
        git \
        vim \
        zsh \
        ca-certificates \
        locales \
        tzdata \
        less \
        unzip \
        build-essential \
        software-properties-common && \
    locale-gen en_US.UTF-8 && \
    rm -rf /var/lib/apt/lists/* && \
    groupadd --gid $USER_GID $USERNAME && \
    useradd --uid $USER_UID --gid $USER_GID -m $USERNAME -s /bin/zsh && \
    echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME && \
    chmod 0440 /etc/sudoers.d/$USERNAME

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    TERM=xterm-256color

USER $USERNAME

WORKDIR /home/$USERNAME

# Git config defaults (optional)
RUN git config --global user.name "Dev User" && \
    git config --global user.email $EMAIL

CMD ["zsh"]