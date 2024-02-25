# llonebot-docker
 llonebot-docker
 docker run -d --name llonebot-docker -e VNC_PASSWD=vncpasswd -p 3000:3000 -p 5900:5900 -p 6081:6081 -p 3001:3001 -v ${PWD}/config:/root/.chronocat/config mlikiowa/llonebot-docker