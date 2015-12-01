FROM alpine:3.2

RUN apk add -U \
	openssh \
	rsync \
 && ssh-keygen -A \
 && adduser -D -s /bin/ash drone \
 && passwd -u drone \
 && mkdir /home/drone/.ssh \
 && sed -i 's/#RSAAuthentication yes/RSAAuthentication yes/' /etc/ssh/sshd_config \
 && sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config

COPY authorized_keys /home/drone/.ssh/
EXPOSE 22

ENTRYPOINT ["/usr/sbin/sshd", "-D", "-e"]
