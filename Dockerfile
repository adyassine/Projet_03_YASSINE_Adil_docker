FROM takeyamajp/debian-sshd
MAINTAINER Adil YASSINE <ad.yassine@gmail.com>

ENV ROOT_PASSWORD=root
ENV TZ=Asia/Tokyo

# Website resources
COPY p3-devops.com /var/www/html