#!/bin/bash

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Image details
IMAGE_NAME="dev-container"
IMAGE_TAG="latest"

# Define default values for USERNAME and EMAIL
DEFAULT_USERNAME="devuser"
DEFAULT_EMAIL="dev@example.com"

# Define default value for BUILD_TYPE
DEFAULT_BUILD_TYPE="minimal"

# Use provided arguments or fall back to defaults
USERNAME=${1:-$DEFAULT_USERNAME}
EMAIL=${2:-$DEFAULT_EMAIL}
BUILD_TYPE=${3:-$DEFAULT_BUILD_TYPE}

echo "Building Docker image with USERNAME=${USERNAME}, EMAIL=${EMAIL}, and BUILD_TYPE=${BUILD_TYPE}"

# Build the Docker image
docker build -t "${IMAGE_NAME}:${IMAGE_TAG}" \
    --build-arg BUILD_DATE="$(date -u +'%Y-%m-%dT%H:%M:%SZ')" \
    --build-arg USERNAME="${USERNAME}" \
    --build-arg EMAIL="${EMAIL}" \
    --target "${BUILD_TYPE}" \
    "$SCRIPT_DIR"

echo "Image '${IMAGE_NAME}:${IMAGE_TAG}' built successfully!
"