FROM ubuntu:precise
MAINTAINER Aater Suleman <aater@flux7.com>
RUN apt-get update 
#RUN apt-get -y upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install python-setuptools vim-tiny openssh-server sudo 

#the following packages are needed to make container identical to AWS ubinti AMI ami-a73264ce

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install libgpg-error0 libp11-kit0 libtasn1-3 libasn1-8-heimdal libhcrypto4-heimdal  libkrb5-26-heimdal libroken18-heimdal libgcrypt11 libgnutls26 librtmp0 libgssapi3-heimdal libsasl2-2 libcurl3-gnutls libldap-2.4-2 
# apparmor does not work inside a container

RUN easy_install supervisor
RUN echo %sudo	ALL=NOPASSWD: ALL >> /etc/sudoers
RUN mkdir /var/log/supervisor/
RUN mkdir /var/run/sshd
RUN mkdir /home/ubuntu
RUN useradd -G sudo -d /home/ubuntu ubuntu
RUN chown ubuntu /home/ubuntu
RUN echo ubuntu:ubuntu | chpasswd
RUN sudo chsh ubuntu -s /bin/bash
RUN mkdir /home/ubuntu/.ssh
ADD key.pub /home/ubuntu/.ssh/authorized_keys
RUN chown -R ubuntu /home/ubuntu/.ssh
ADD ./supervisord.conf /etc/supervisord.conf

EXPOSE 80
EXPOSE 22
EXPOSE 6379

CMD ["/bin/bash", "supervisord", "-n"]

