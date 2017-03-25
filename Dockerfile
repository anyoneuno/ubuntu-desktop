#
# Ubuntu Desktop (LXDE) Dockerfile
#
# https://github.com/dockerfile/ubuntu-desktop
#

# Pull base image.
FROM dockerfile/ubuntu
MAINTAINER anyoneuno "https://github.com/anyoneuno"

# Install LXDE and VNC server.
RUN \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y lxde-core lxterminal tightvncserver && \
  rm -rf /var/lib/apt/lists/*
  
# Install SSH
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd

RUN echo 'root:root' |chpasswd

RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

CMD    ["/usr/sbin/sshd", "-D"]

# Define working directory.
WORKDIR /data

# Define default command.
CMD ["bash"]

# Expose ports.
EXPOSE 5901
EXPOSE 22

RUN apt-get update
