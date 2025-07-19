# Dev Container

This project provides a Dockerized development environment.

## Getting Started

### Prerequisites

* [Docker](https://docs.docker.com/get-docker/)

### Installation

1.  **Build the Docker image:**

    ```sh
    ./build.sh
    ```

2.  **Run the Docker container:**

    ```sh
    ./run.sh
    ```

## Files

*   `Dockerfile`: The recipe for building the Docker image. It contains all the commands to assemble an image.
*   `build.sh`: A convenience script for building the Docker image.
*   `run.sh`: A convenience script for running the Docker container.
*   `.dockerignore`: This file lists files and directories that should be excluded when building the Docker image. This helps to keep the image size small and reduces build time.
