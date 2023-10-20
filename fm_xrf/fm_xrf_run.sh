docker container rm -f fm_xrf_ssh
docker run -d \
        --gpus all \
        -p 34728:22 \
        -v /etc/passwd:/etc/passwd:ro \
        -v /etc/shadow:/etc/shadow:ro \
        -v /etc/group:/etc/group:ro \
        -v /home/aslee/fm_xrf:/home/${USER} \
        --name fm_xrf_ssh fm_xrf/pytorch:v1
