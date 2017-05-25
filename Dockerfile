FROM m0kimura/ubuntu-user

ARG user=${user:-docker}
RUN apt-get update && \
    apt-get install -y sudo wget nano openjdk-8-jre && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ADD arduino-1.8.2-linux64.tar.xz /home/${user}
ADD arduino15 /home/${user}/.arduino15/
RUN chown -R ${user}:${user} /home/${user}
VOLUME /home/${user}

WORKDIR /home/${user}
USER ${user}
RUN echo sketchbook.path=/home/${user}/Arduino >> /home/${user}/.arduino15/preferences.txt
ENV HOME /home/${user}
CMD arduino-1.8.2/arduino

