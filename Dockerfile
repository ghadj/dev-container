FROM ubuntu:latest

# Set build-time arguments
ARG BUILD_DATE
ARG DEBIAN_FRONTEND=noninteractive
ARG USERNAME
ARG USER_UID=1001
ARG USER_GID=1001
ARG EMAIL

# Set environment variables
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    TERM=xterm-256color \
    NVM_DIR=/home/${USERNAME}/.nvm \
    NODE_VERSION=22

# Set container metadata
LABEL maintainer=${EMAIL}
LABEL org.label-schema.build-date=${BUILD_DATE}
LABEL description="Lightweight Ubuntu dev environment with zsh, sudo, and common tools"

# Install system dependencies, create a non-root user, and clean up
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        sudo curl wget git vim zsh ca-certificates locales tzdata less unzip build-essential software-properties-common && \
    locale-gen en_US.UTF-8 && \
    rm -rf /var/lib/apt/lists/* && \
    groupadd --gid ${USER_GID} ${USERNAME} && \
    useradd --uid ${USER_UID} --gid ${USER_GID} -m ${USERNAME} -s /bin/zsh && \
    echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USERNAME} && \
    chmod 0440 /etc/sudoers.d/${USERNAME}

# Switch to the non-root user
USER ${USERNAME}
WORKDIR /home/${USERNAME}

# Set default Git configuration
RUN git config --global user.name "${USERNAME}" && \
    git config --global user.email "${EMAIL}"

# Add a healthcheck
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 CMD [ "zsh", "-c", "echo 'Container is healthy'" ]

# Set the default command to run when the container starts
CMD ["zsh"]