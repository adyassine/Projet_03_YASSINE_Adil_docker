FROM debian:latest
MAINTAINER Adil YASSINE <ad.yassine@gmail.com>

# timezone
RUN apt-get update && apt-get install -y tzdata nginx; \
    apt-get clean;

# nginx
RUN apt-get install -y tzdata nginx; \
    apt-get clean;

# sshd
RUN mkdir /var/run/sshd; \
    apt-get install -y openssh-server; \
    sed -i 's/^#\(PermitRootLogin\) .*/\1 yes/' /etc/ssh/sshd_config; \
    sed -i 's/^\(UsePAM yes\)/# \1/' /etc/ssh/sshd_config; \
    apt clean;

# entrypoint
RUN { \
    echo '#!/bin/bash -eu'; \
    echo 'ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime'; \
    echo 'echo "root:${ROOT_PASSWORD}" | chpasswd'; \
    echo 'exec "$@"'; \
    } > /usr/local/bin/entry_point.sh; \
    chmod +x /usr/local/bin/entry_point.sh;

# Website resources
COPY p3-devops.com /var/www/html

ENV TZ Asia/Tokyo
ENV ROOT_PASSWORD root

EXPOSE 80 22
ENTRYPOINT entry_point.sh && service ssh restart && nginx -g 'daemon off;'