ARG UBUNTU_VERSION
FROM ubuntu:${UBUNTU_VERSION}

ENV DEBIAN_FRONTEND=noninteractive \
    TERM=xterm \
    DISPLAY=:1 \
    VNC_PORT=5901 \
    NO_VNC_PORT=6901 \
    HOME=/docker

EXPOSE $VNC_PORT \
       $NO_VNC_PORT

RUN apt update && \
    apt clean && \
    apt install -y --no-install-recommends \
        fluxbox \
        wmctrl \
        x11vnc \
        xvfb

RUN apt install -y --no-install-recommends \
        curl \
        ca-certificates \
        gnupg

RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg && \
    install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/ && \
    sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > \
        /etc/apt/sources.list.d/vscode.list' && \
    apt install -y --no-install-recommends apt-transport-https && \
    apt update && \
    apt install -y --no-install-recommends \
        code \
        libasound2

# RUN apt install -y \
#         net-tools \
#         python \
#         wget && \
#     mkdir -p $HOME/noVNC/utils/websockify && \
#     wget -qO- https://github.com/novnc/noVNC/archive/v0.6.2.tar.gz | tar xz --strip 1 -C $HOME/noVNC && \
#     wget -qO- https://github.com/novnc/websockify/archive/v0.6.1.tar.gz | \
#         tar xz --strip 1 -C $HOME/noVNC/utils/websockify && \
#     chmod +x -v $HOME/noVNC/utils/*.sh && \
#     ln -s $HOME/noVNC/vnc_auto.html $HOME/noVNC/index.html

COPY bootstrap.sh /

RUN chmod a+x /bootstrap.sh

RUN groupadd --gid 999 appuser && \
    useradd --gid 999 --uid 999 --create-home --shell /bin/bash appuser

USER appuser

ENV HOME=/home/appuser

WORKDIR /home/appuser

COPY fluxbox/* ${HOME}/.fluxbox/

CMD '/bootstrap.sh'
