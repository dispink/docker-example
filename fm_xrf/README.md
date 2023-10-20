# SEISAN Docker Image

[run_ssh.sh](run_ssh.sh) will remove the previous created container and start a new one.



In [run_ssh.sh](run_ssh.sh):

``` bash
docker container rm -f seisan_ssh
docker run -d \
        -p 49154:22 \
        -v /etc/passwd:/etc/passwd:ro \
        -v /etc/shadow:/etc/shadow:ro \
        -v /etc/group:/etc/group:ro \
        --name fm_xrf_ssh fm_xrf/pytorch
```

1. Create a workspace directory.
1. Link `<path/to/workspace>` to the user home directory.
1. Change `49154` to any number for SSH port.
1. Change `fm_xrf_ssh` to any container name.
1. Save and run `run_ssh.sh`.
1. SSH into the docker container with your user account.

       ssh user@remote-ip -p 49154