# Docker Example

This repo is inspired by [SGYLAB](https://github.com/sgylab/docker-example/tree/master) and has two purpose:

1. Demonstrates how to build docker containers.
2. Maintains docker images used by LYS lab.

## Why use container

-   **Isolation**: The container is isolated from the host machine. It's like a 
    virtual machine but more lightweight. It's a good practice to 
    keep the host machine clean and tidy. The container can be easily removed 
    and rebuilt if it's broken or messed up.
-   **Consistency**: Team members can use a consistent environment and 
    tool-chain. The results or errors can be conveniently reproduced by others.
-   **Portability**: The container can be shared and reproduced across
    platforms. This makes it easier for new contributors or team members to be productive quickly. First-time contributors will require less guidance and hit fewer issues related to environment setup.

There are more benefits of using container. See [here](https://www.docker.com/resources/what-container).

## Image build status

Docker Template|Method|Status
:-----------|:--------|:--------  
[fm_xrf](fm_xrf)|Dockerfile|Done
[cuda118](devcontainers/cuda118)|Dev Container|Done

## Useful docker commands 

Build image with Dockerfile:

    docker build -t [image name] .

Update image:

    docker pull [image name]

List exist container:

    docker container ls

Resume stopped container:

    docker start [container name]

Remove container:

    docker container rm [container name]

Remove image:

    docker image rm [image name]

## Danger zone

Remove all containers(!):

    docker rm -f $(docker ps -a -q)

Remove all images(!):

    docker rmi -f $(docker images -q)
