# LLOneBot-Docker
[DockerHub](https://hub.docker.com/r/mlikiowa/llonebot-docker)
## 快速启动
 ```bash
 sudo docker run -d --name onebot-docker0 -e VNC_PASSWD=vncpasswd -p 3000:3000 -p 5900:5900 -p 6081:6081 -p 3001:3001 -v ${PWD}/LiteLoader/:/opt/QQ/LiteLoader/ mlikiowa/llonebot-docker
 ```
其中vncpasswd换成你的VNC密码
或者下载代码中的docker-compose.yml，然后执行

```bash
sudo docker-compose up -d
```
## 数据固化
### 暂时忽略 未实现QQ本体数据固化 仅实现LiteLoader包括其所有插件数据固化 无需阅读该条目录
先完成上面的`快速运行`，保证容器在运行状态

如果之前是docker run运行的，执行

```bash
 sudo docker run -d --name onebot-docker0 -e VNC_PASSWD=vncpasswd -p 3000:3000 -p 5900:5900 -p 6081:6081 -p 3001:3001 -v ${PWD}/LiteLoader/:/opt/QQ/LiteLoader/ mlikiowa/llonebot-docker
```

如果之前是docker-compose运行的

```bash
docker-compose up -d
```
### noVNC登陆

浏览器访问`http://服务器IP:6081`，默认密码是`vncpasswd`

### VNC登陆

使用VNC软件登陆`服务器IP:5900`，默认密码是`vncpasswd`


### 修改VNC密码

```bash
sudo docker exec onebot-docker0 sh -c "x11vnc -storepasswd newpasswd /root/.vnc/passwd"
```
其中newpasswd换成你的新密码，立即生效，无需重启容器

# 参考与基础
[linyuchen/LiteLoaderQQNT-OneBotApi](https://github.com/linyuchen/LiteLoaderQQNT-OneBotApi)

[yuuki-nya/chronocat-docker](https://github.com/yuuki-nya/chronocat-docker/blob/main/Dockerfile)

## 已知问题与提示
### 1.快速闪退
如果连接反向ws后快速闪退 清空容器数据之后 再次配置先启用上报自身消息 在vnc窗口复制 之前触发机器人的消息 使用机器人账号发送 再正常使用bot
