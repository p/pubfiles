FROM ubuntu:bionic

RUN apt-get update && \
  apt-get install -y curl libxcb-keysyms1 libglib2.0-0 libxcb-shape0 \
    libxcb-shm0 libxcb-xfixes0 libxcb-randr0 libxcb-image0 libfontconfig1 \
    libgl1-mesa-glx libegl1-mesa libxi6 libsm6 libxrender1 libpulse0 \
    libxcomposite1 libxslt1.1 libxcb-xtest0 libdbus-1-3 libxtst6 ibus \
    libxcb-xinerama0 libxkbcommon-x11-0 libfreetype6 && \
  curl -fLo zoom_amd64.deb --retry 3 https://zoom.us/client/latest/zoom_amd64.deb && \
  dpkg -i zoom_amd64.deb

RUN apt-get install -y xterm xauth mplayer wget

RUN useradd -G audio,video -m -u 2515 w && id && echo deep2 > /etc/hostname

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
