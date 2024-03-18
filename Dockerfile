FROM mlikiowa/llonebot-docker:base

ENV DEBIAN_FRONTEND=noninteractive
ENV VNC_PASSWD=vncpasswd
COPY start.sh /root/start.sh
COPY config/LLWebUiApi_config.json /root/LLWebUiApi_config.json

RUN arch=$(arch | sed s/aarch64/arm64/ | sed s/x86_64/amd64/) && \
    curl -o /root/linuxqq.deb https://dldir1.qq.com/qqfile/qq/QQNT/852276c1/linuxqq_3.2.5-21453_${arch}.deb && \
    dpkg -i /root/linuxqq.deb && apt-get -f install -y && rm /root/linuxqq.deb && \
    # 下载LiteLoader
    curl -L -o /tmp/LiteLoaderQQNT.zip https://github.com/LiteLoaderQQNT/LiteLoaderQQNT/releases/download/1.0.3/LiteLoaderQQNT.zip && \
    mkdir -p /opt/QQ/resources/app/LiteLoader && \
        ##  ---调试开启  检测文件情况 ls /opt/QQ/resources/app/app_launcher/ && \
    # 修补QQ载入LiteLoader
    sed -i "1i\require('/opt/QQ/resources/app/LiteLoader/');" /opt/QQ/resources/app/app_launcher/index.js && \
        ##  ---调试开启 检测修补情况 cat /opt/QQ/resources/app/app_launcher/index.js  && \
    # 下载LLOneBot
    curl -L -o /tmp/LLOneBot.zip https://github.com/LLOneBot/LLOneBot/releases/download/$(curl -Ls "https://api.github.com/repos/LLOneBot/LLOneBot/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')/LLOneBot.zip && \
    # 下载LLWebUiApi
    curl -L -o /tmp/LLWebUiApi.zip https://github.com/LLOneBot/LLWebUiApi/releases/download/$(curl -Ls "https://api.github.com/repos/LLOneBot/LLWebUiApi/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')/LLWebUiApi.zip && \
    # 自动配置
    \
    chmod +x ~/start.sh && \
    \
    echo "[supervisord]" > /etc/supervisord.conf && \
    echo "nodaemon=true" >> /etc/supervisord.conf && \
    echo "[program:qq]" >> /etc/supervisord.conf && \
    echo "command=qq --no-sandbox" >> /etc/supervisord.conf && \
    echo 'environment=DISPLAY=":1"' >> /etc/supervisord.conf
    
VOLUME ["/opt/QQ/resources/app/LiteLoader"]
# 设置容器启动时运行的命令
CMD ["/bin/bash", "-c", "startx & sh /root/start.sh"]
