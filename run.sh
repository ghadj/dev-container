#!/bin/bash

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Image details
IMAGE_NAME="dev-container"
IMAGE_TAG="latest"

# Project directory on the host
PROJECT_DIR="$SCRIPT_DIR/Project"

# Create the project directory if it doesn't exist
mkdir -p "$PROJECT_DIR"

# Run the container
docker run -it --rm \
    -v "$PROJECT_DIR:/home/devuser/Project" \
    -v "$HOME/.ssh:/home/devuser/.ssh:ro" \
    "${IMAGE_NAME}:${IMAGE_TAG}"