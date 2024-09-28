FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive \
    VNC_PASSWD=vncpasswd \
    TZ=Asia/Shanghai

RUN apt-get update && apt-get install -y \
    openbox \
    xorg \
    dbus-user-session \
    curl \
    unzip \
    xvfb \
    supervisor \
    libnotify4 \
    libnss3 \
    xdg-utils \
    libsecret-1-0 \
    ffmpeg \
    libgbm1 \
    libasound2 \
    fonts-wqy-zenhei \
    git \
    gnutls-bin \
    tzdata && \
    echo "${TZ}" > /etc/timezone && \ 
    ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime && \
    apt autoremove -y && \
    apt clean && \
    rm -rf \
    /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/*