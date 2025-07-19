# Dev Container

This project provides a Dockerized development environment.

## Getting Started

### Prerequisites

* [Docker](https://docs.docker.com/get-docker/)

### Installation

1.  **Build the Docker image:**

    To build with default user (`devuser`) and email (`dev@example.com`):
    ```sh
    ./build.sh
    ```
    To build with a custom user and email:
    ```sh
    ./build.sh "your_username" "your_email@example.com"
    ```

2.  **Run the Docker container:**

    To run with the default user (`devuser`):
    ```sh
    ./run.sh
    ```
    To run with a custom user (must match the username used during build):
    ```sh
    ./run.sh "your_username"
    ```

## Files

*   `Dockerfile`: The recipe for building the Docker image. It contains all the commands to assemble an image.
*   `build.sh`: A convenience script for building the Docker image.
*   `run.sh`: A convenience script for running the Docker container.
*   `.dockerignore`: This file lists files and directories that should be excluded when building the Docker image. This helps to keep the image size small and reduces build time.
