#!/bin/bash

mkdir -p /opt/QQ/resources/app/LiteLoader/plugins/LLOneBot
mkdir -p /opt/QQ/resources/app/LiteLoader/plugins/LLWebUiApi
# 安装 LiteLoader
if [ ! -f "/opt/QQ/resources/app/LiteLoader/package.json" ]; then
    unzip /tmp/LiteLoaderQQNT.zip -d /opt/QQ/resources/app/LiteLoader/
fi

# 安装 LLOneBot
if [ ! -f "/opt/QQ/resources/app/LiteLoader/plugins/LLOneBot/manifest.json" ]; then
    unzip /tmp/LLOneBot.zip -d /opt/QQ/resources/app/LiteLoader/plugins/LLOneBot/
    unzip /tmp/LLWebUiApi.zip -d /opt/QQ/resources/app/LiteLoader/plugins/LLWebUiApi/
    # 设置启动模式
    if [ "$BOOT_MODE" ]; then
        mkdir -p /opt/QQ/resources/app/LiteLoader/data/LLWebUiApi
        cp /root/LLWebUiApi_config.json /opt/QQ/resources/app/LiteLoader/data/LLWebUiApi/config.json
        sed -i "s/BOOT_MODE/$BOOT_MODE/" /opt/QQ/resources/app/LiteLoader/data/LLWebUiApi/config.json
    fi
fi

chmod 777 /tmp &
rm -rf /run/dbus/pid &
rm /tmp/.X1-lock &
mkdir -p /var/run/dbus &
dbus-daemon --config-file=/usr/share/dbus-1/system.conf --print-address &
Xvfb :1 -screen 0 1080x760x16 &
export DISPLAY=:1
# --disable-gpu 不加入
exec supervisord