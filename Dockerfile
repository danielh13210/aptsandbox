FROM ubuntu:latest
RUN apt-get update && apt-get install --no-install-recommends -y sudo
RUN userdel ubuntu && rm -rf /home/ubuntu
RUN touch /.firstrun
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/bin/bash", "/entrypoint.sh" ]