# nodelab image

FROM redhat/ubi8-init

LABEL org.opencontainers.image.source https://github.com/goffinet/nodelab

ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

RUN echo "enabled=0" >> /etc/yum/pluginconf.d/subscription-manager.conf

RUN dnf install -y glibc-langpack-en openssh-server openssh-clients sudo && ssh-keygen -A

RUN useradd user && \
    echo "user  ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers && \
    su -c "ssh-keygen -f ~/.ssh/id_rsa -N ''" - user && \
    echo "user" | passwd --stdin user

RUN systemctl enable sshd

EXPOSE 22
