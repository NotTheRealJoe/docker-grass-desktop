FROM docker.io/ubuntu:latest AS grass-desktop-package-builder

RUN apt-get -y update; apt-get -y --no-install-recommends --no-install-suggests install binutils wget ca-certificates

RUN wget -q -O /tmp/grass.deb https://files.getgrass.io/file/grass-extension-upgrades/ubuntu-latest/grass_4.26.5_amd64.deb

RUN mkdir /tmp/grass-fix
WORKDIR /tmp/grass-fix

RUN ar -x ../grass.deb
RUN tar -xzvf control.tar.gz
RUN sed -i 's/Package\: grass/Package\: getgrass-io/' control
RUN tar -czvf control.tar.gz control md5sums
RUN rm control md5sums
RUN ar r ../grass.deb *

WORKDIR /
RUN rm -r /tmp/grass-fix

FROM docker.io/ubuntu:latest

RUN apt-get -y update; apt-get -y --no-install-recommends --no-install-suggests install \
    wget tini gpg openbox ca-certificates xdotool

RUN update-ca-certificates

# Install TurboVNC
RUN wget -q -O- https://packagecloud.io/dcommander/turbovnc/gpgkey | gpg --dearmor > /etc/apt/trusted.gpg.d/TurboVNC.gpg
RUN wget -q -O /etc/apt/sources.list.d/turbovnc.list https://raw.githubusercontent.com/TurboVNC/repo/main/TurboVNC.list
RUN apt-get -y update; apt-get -y install turbovnc

# Install grass, fixing package
COPY --from=grass-desktop-package-builder /tmp/grass.deb /tmp/grass.deb
RUN dpkg -i /tmp/grass.deb; apt-get -y --fix-broken --no-install-recommends --no-install-suggests install
RUN rm /tmp/grass.deb

RUN apt-get -y install adduser
RUN adduser grass

# Remove packages only needed for the build
RUN apt-get -y --purge purge wget gpg adduser
RUN apt-get -y --purge autoremove

USER grass:grass
COPY --chown=grass --chmod=700 start.sh /home/grass/start.sh

ENTRYPOINT tini -s /home/grass/start.sh
