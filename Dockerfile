FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV VNC_PASSWD=vncpasswd
RUN groupadd -r LLOneBot && useradd -r -g LLOneBot LLOneBot  && \
    apt-get update && apt-get install -y \
    openbox \
    curl \
    unzip \
    x11vnc \
    xvfb \
    fluxbox \
    supervisor \
    libnotify4 \
    libnss3 \
    xdg-utils \
    libsecret-1-0 \
    libgbm1 \
    libasound2 \
    fonts-wqy-zenhei \
    git \
    gnutls-bin && \    
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    # 安装NoVnc
    \
    git config --global http.sslVerify false && git config --global http.postBuffer 1048576000 && \
    cd /opt && git clone https://github.com/novnc/noVNC.git && \
    cd /opt/noVNC/utils && git clone https://github.com/novnc/websockify.git && \
    cp /opt/noVNC/vnc.html /opt/noVNC/index.html   && \
    \
    # 安装QQ
    curl -o /root/linuxqq_3.2.5-21453_amd64.deb https://dldir1.qq.com/qqfile/qq/QQNT/852276c1/linuxqq_3.2.5-21453_amd64.deb && \
    dpkg -i /root/linuxqq_3.2.5-21453_amd64.deb && apt-get -f install -y && rm /root/linuxqq_3.2.5-21453_amd64.deb && \
    # 安装LiteLoader
    curl -L -o /tmp/LiteLoaderQQNT.zip https://github.com/LiteLoaderQQNT/LiteLoaderQQNT/releases/download/1.0.3/LiteLoaderQQNT.zip && \
    mkdir /opt/QQ/resources/app/LiteLoader/ && mkdir /tmp/LiteLoader/ && \
    unzip /tmp/LiteLoaderQQNT.zip -d /tmp/LiteLoader/ && \
    mv /tmp/LiteLoader/* /opt/QQ/resources/app/LiteLoader/ && \
        ##  ---调试开启  检测文件情况 ls /opt/QQ/resources/app/app_launcher/ && \
    rm /tmp/LiteLoaderQQNT.zip && \
    # 修补QQ载入LiteLoader
    sed -i "1i\require('/opt/QQ/resources/app/LiteLoader/');" /opt/QQ/resources/app/app_launcher/index.js && \
        ##  ---调试开启 检测修补情况 cat /opt/QQ/resources/app/app_launcher/index.js  && \
    # 安装LLOneBot
    mkdir /opt/QQ/resources/app/LiteLoader/plugins/ && \
    mkdir /opt/QQ/resources/app/LiteLoader/plugins/LLOneBot/ && \
    curl -L -o /tmp/LLOneBot.zip https://github.com/linyuchen/LiteLoaderQQNT-OneBotApi/releases/download/v3.7.0/LLOneBot.zip && \
    unzip /tmp/LLOneBot.zip -d /opt/QQ/resources/app/LiteLoader/plugins/LLOneBot/ && \
    rm /tmp/LLOneBot.zip && \
    # 自动配置
    # 五阶段
    \
    mkdir -p ~/.vnc && \
    \
    echo "#!/bin/bash" > ~/start.sh && \
    echo "rm /tmp/.X1-lock" >> ~/start.sh && \
    echo "Xvfb :1 -screen 0 1280x1024x16 &" >> ~/start.sh && \
    echo "export DISPLAY=:1" >> ~/start.sh && \
    echo "fluxbox &" >> ~/start.sh && \ 
    echo "x11vnc -display :1 -noxrecord -noxfixes -noxdamage -forever -rfbauth ~/.vnc/passwd &" >> ~/start.sh && \
    echo "nohup /opt/noVNC/utils/novnc_proxy --vnc localhost:5900 --listen 6081 --file-only &" >> ~/start.sh && \
    echo "x11vnc -storepasswd \$VNC_PASSWD ~/.vnc/passwd" >> ~/start.sh && \
    echo "qq" >> ~/start.sh && \
    chmod +x ~/start.sh && \
    \
    echo "[supervisord]" > /etc/supervisor/supervisord.conf && \
    echo "nodaemon=true" >> /etc/supervisor/supervisord.conf && \
    echo "[program:x11vnc]" >> /etc/supervisor/supervisord.conf && \
    echo "command=/usr/bin/x11vnc -display :1 -noxrecord -noxfixes -noxdamage -forever -rfbauth ~/.vnc/passwd" >> /etc/supervisor/supervisord.conf
USER ubuntu
# 设置容器启动时运行的命令
CMD ["/bin/bash", "-c", "/root/start.sh"]