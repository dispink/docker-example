# Docker Example

This repo is inspired by [SGYLAB](https://github.com/sgylab/docker-example/tree/master) and has two purpose:

1. Demonstrates how to build docker images by Github Actions.
2. Maintains docker images used by LYS lab.

The Github Actions will be developed.

## Image build status

Docker Image|Status
:-----------|:-----
[dispink/fm_xrf](fm_xrf)|Developing

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
