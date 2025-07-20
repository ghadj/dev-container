# Base Stage
FROM ubuntu:22.04 AS base

# Define build-time arguments with defaults
ARG BUILD_DATE
ARG DEBIAN_FRONTEND=noninteractive
ARG USERNAME=devuser
ARG USER_UID=1001
ARG USER_GID=1001
ARG EMAIL=dev@example.com

# Set environment variables (after defining ARGs)
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    TERM=xterm-256color \
    USERNAME=${USERNAME} \
    NVM_DIR=/home/${USERNAME}/.nvm \
    NODE_VERSION=22

# Set container metadata
LABEL maintainer="${EMAIL}"
LABEL org.label-schema.build-date="${BUILD_DATE:-2025-07-20}"
LABEL description="Lightweight Ubuntu dev environment with zsh, sudo, and common tools"

# Install system packages and create non-root user
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        sudo curl wget git vim zsh ca-certificates locales tzdata \
        less unzip build-essential software-properties-common && \
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen en_US.UTF-8 && \
    groupadd --gid ${USER_GID} ${USERNAME} && \
    useradd --uid ${USER_UID} --gid ${USER_GID} -m ${USERNAME} -s /bin/zsh && \
    echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USERNAME} && \
    chmod 0440 /etc/sudoers.d/${USERNAME} && \
    rm -rf /var/lib/apt/lists/*

# Set working directory and switch to non-root user
USER ${USERNAME}
WORKDIR /home/${USERNAME}

# Configure git (optional — only if EMAIL is passed)
RUN git config --global user.name "${USERNAME}" && \
    git config --global user.email "${EMAIL}"

# Healthcheck (basic — always passes)
HEALTHCHECK CMD [ "zsh", "-c", "exit 0" ]

# Default command
CMD ["zsh"]

# Full Stage (extra tools)
FROM base AS full

# TODO

# Minimal Stage (just base)
FROM base AS minimal

# Nothing extra added
