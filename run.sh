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

# Check if the GEMINI_API_KEY environment variable is not set
# Define default username
DEFAULT_USERNAME="devuser"

# Use provided argument or fall back to default
USERNAME=${1:-$DEFAULT_USERNAME}

# Check if the GEMINI_API_KEY environment variable is not set
if [ -z "$GEMINI_API_KEY" ]; then
    echo "Error: The GEMINI_API_KEY environment variable is not set."
    echo "Please set it before running this script."
    exit 1
fi

# Run the container
docker run -it --rm \
    -v "$PROJECT_DIR:/home/${USERNAME}/Project" \
    -v "$HOME/.ssh:/home/${USERNAME}/.ssh:ro" \
    -e GEMINI_API_KEY="$GEMINI_API_KEY" \
    "${IMAGE_NAME}:${IMAGE_TAG}"
