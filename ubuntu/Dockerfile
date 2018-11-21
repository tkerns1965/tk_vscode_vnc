ARG UBUNTU_VERSION
FROM ubuntu:${UBUNTU_VERSION}

RUN apt update && \
    DEBIAN_FRONTEND=noninteractive \
    apt install -yq --no-install-recommends \
        fluxbox \
        wmctrl \
        x11vnc \
        xvfb && \
    apt clean

RUN DEBIAN_FRONTEND=noninteractive \
    apt install -yq --no-install-recommends \
        curl \
        ca-certificates \
        gnupg

RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg && \
    install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/ && \
    sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > \
        /etc/apt/sources.list.d/vscode.list' && \
    DEBIAN_FRONTEND=noninteractive \
    apt install -yq --no-install-recommends \
        apt-transport-https && \
    apt update && \
    DEBIAN_FRONTEND=noninteractive \
    apt install -yq --no-install-recommends \
        code \
        libasound2

# RUN apt install -y \
#         net-tools \
#         python \
#         wget && \
#     mkdir -p $HOME_DIR/noVNC/utils/websockify && \
#     wget -qO- https://github.com/novnc/noVNC/archive/v0.6.2.tar.gz | tar xz --strip 1 -C $HOME_DIR/noVNC && \
#     wget -qO- https://github.com/novnc/websockify/archive/v0.6.1.tar.gz | \
#         tar xz --strip 1 -C $HOME/noVNC/utils/websockify && \
#     chmod +x -v $HOME_DIR/noVNC/utils/*.sh && \
#     ln -s $HOME_DIR/noVNC/vnc_auto.html $HOME/noVNC/index.html

ARG APP_USER

RUN groupadd --gid 999 ${APP_USER} && \
    useradd --gid 999 --uid 999 --create-home --shell /bin/bash ${APP_USER}

USER ${APP_USER}

ENV DISPLAY=:1 \
    HOME_DIR=/home/${APP_USER}

WORKDIR ${HOME_DIR}

COPY --chown=999:999 fluxbox/* .fluxbox/
COPY --chown=999:999 bootstrap.sh .

RUN chmod u+x bootstrap.sh

CMD "bootstrap.sh"
