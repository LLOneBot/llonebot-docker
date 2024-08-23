FROM mlikiowa/llonebot-docker:latest

COPY start.sh /root/start.sh

RUN apt-get update && apt-get install -y \
    fluxbox \
    x11vnc && \    
    apt autoremove -y && \
    apt clean && \
    rm -rf \
    /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/* && \
    mkdir -p ~/.vnc && \
    chmod +x /root/start.sh