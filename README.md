# LLOneBot-Docker
[DockerHub](https://hub.docker.com/r/mlikiowa/llonebot-docker)
## 快速启动
 ```bash
 sudo docker run -d --name onebot-docker0 -e VNC_PASSWD=vncpasswd -p 3000:3000 -p 5900:5900 -p 6081:6081 -p 3001:3001 -v ${PWD}/config:/root/.chronocat/config mlikiowa/llonebot-docker
 ```
其中vncpasswd换成你的VNC密码
或者下载代码中的docker-compose.yml，然后执行

```bash
sudo docker-compose up -d
```
## 数据固化（可选）

### noVNC登陆

浏览器访问`http://服务器IP:6081`，默认密码是`vncpasswd`

### VNC登陆

使用VNC软件登陆`服务器IP:5900`，默认密码是`vncpasswd`


### 修改VNC密码

```bash
sudo docker exec onebot-docker0 sh -c "x11vnc -storepasswd newpasswd /root/.vnc/passwd"
```
其中newpasswd换成你的新密码，立即生效，无需重启容器
