# LLOneBot-Docker
[DockerHub](https://hub.docker.com/r/mlikiowa/llonebot-docker)

## Information
请注意! 该项目使用应当遵守上游开源库协议与要求，遵守当地法律与规范。

该项目适用于快速将NTQQ Bot托管容器，提供 VNC，以便远程登录和配置。

## Support Platform/Arch
- [x] Linux/Amd64
- [x] Linux/Arm64

## Image Layer

- mlikiowa/llonebot-docker:latest
    - 不提供 VNC, 只能通过 LLWebUiApi 来登录
- mlikiowa/llonebot-docker:vnc
    - 提供了 VNC

## Install
1. 安装参考已选方案一与方案二 启动
2. 远程登录，VNC登录 `服务器IP:5900`
   
## 使用方案（一）VNC登录
 ```bash
 sudo docker run -d --name onebot-docker0 -e VNC_PASSWD=vncpasswd -p 3000:3000 -p 5900:5900 -p 3001:3001 -v ${PWD}/LiteLoader:/opt/QQ/resources/app/LiteLoader mlikiowa/llonebot-docker:vnc
 ```
其中vncpasswd换成你的VNC密码
或者下载代码中的docker-compose.yml，然后执行

```bash
sudo docker-compose up -d
```

等待 docker 启动完毕后使用 vnc 客户端连接进入 docker Linux 桌面登录 QQ 和配置 LLOneBot

## 使用方案（二）webui登录

 ```bash
curl https://cdn.jsdelivr.net/gh/LLOneBot/llonebot-docker/fastboot.sh -o fastboot.sh & chmod +x fastboot.sh & sudo sh fastboot.sh
 ```
 ```bash
wget -O fastboot.sh https://cdn.jsdelivr.net/gh/LLOneBot/llonebot-docker/fastboot.sh & chmod +x fastboot.sh & sudo sh fastboot.sh
 ```

然后浏览器访问 `http://你的docker-ip:6099/api/panel/getQQLoginQRcode` 扫码登录

登录之后访问 `http://你的docker-ip:6099/plugin/LLOneBot/iframe.html` 进行 llonebot 的配置

## Feat
### 崩溃快速重启
你仅仅需要到设置配置自动登录，保证崩溃时手机QQ不在线即可，其余时间可以使用手机QQ

### 数据固化
暂时忽略 未实现QQ本体数据固化 仅实现LiteLoader包括其所有插件数据固化(按照以上流程启动无须考虑，已自动启用) 无需阅读该条目录 


## 参考与基础
[LLOneBot/LLOneBot](https://github.com/LLOneBot/LLOneBot)

[yuuki-nya/chronocat-docker](https://github.com/yuuki-nya/chronocat-docker/blob/main/Dockerfile)

## 已知问题与提示
### 1.快速闪退
如果连接反向ws后快速闪退 清空容器数据之后 再次配置先启用上报自身消息 在vnc窗口复制 之前触发机器人的消息 使用机器人账号发送 再正常使用bot

### 2.发送文件
需要挂载相应文件夹
