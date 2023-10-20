FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04

# Ignore all interactive dialog during apt-get update
ENV DEBIAN_FRONTEND noninteractive

# Install linux package
RUN apt-mark hold libcudnn* cuda*; \
    apt-get update && apt-get upgrade -y; \
    apt-get install -y \
    python3-dev python3-pip \
    ssh sudo vim htop git

# Python package install
COPY requirements.txt ./requirements.txt
RUN python3 -m pip install --upgrade pip;
RUN python3 -m pip --no-cache-dir install --requirement ./requirements.txt;

# We use SSH to access remote docker since it's familiar to us, but it's less safe
# SSH login fix. Otherwise user is kicked off after login
RUN mkdir /var/run/sshd; \
    sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config; \
    sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd;

# Hide server profile form docker container, only which written into '/etc/profile' will be seen
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile;

# Delete login message for sftp login by replacing default .bashrc
RUN mv /etc/bash.bashrc /etc/bash.bashrc.old; \
    cp /etc/skel/.bashrc /etc/bash.bashrc;

# Open SSH port 22 and make SSHD standby for incoming connection
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
