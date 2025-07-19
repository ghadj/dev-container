#!/bin/bash

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Image details
IMAGE_NAME="dev-container"
IMAGE_TAG="latest"

# Build the Docker image
docker build -t "${IMAGE_NAME}:${IMAGE_TAG}" \
    --build-arg BUILD_DATE="$(date -u +'%Y-%m-%dT%H:%M:%SZ')" \
    "$SCRIPT_DIR"

echo "Image '${IMAGE_NAME}:${IMAGE_TAG}' built successfully."