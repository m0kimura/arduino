FROM m0kimura/ubuntu-jdk

ARG user=${user:-docker}

ADD arduino-1.8.2-linux64.tar.xz /home/${user}
ADD arduino15 /home/${user}/.arduino15/
ADD starter.sh /home/${user}/starter.sh
RUN echo sketchbook.path=/home/${user}/Arduino >> /home/${user}/.arduino15/preferences.txt && \
    chown -R ${user}:${user} /home/${user} && \
    usermod -a -G dialout ${user}

VOLUME /home/${user}
WORKDIR /home/${user}
USER ${user}
ENV HOME=/home/${user} USER=${user}
CMD arduino-1.8.2/arduino

