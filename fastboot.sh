#!/bin/bash
echo "Project llonebot-docker By Mlikiowa"

# 检查Docker是否已安装
if command -v docker &> /dev/null; then
    docker_installed=true
else
    docker_installed=false
fi
# 安装Docker
# Version 19.0.0
if [ "$docker_installed" = true ]; then
    echo "Docker已安装。正在安装脚本..."
    # 在此处添加您的启动命令
else
    echo "Docker未安装。即将开始安装Docker..."
    sudo curl -fsSL https://get.docker.com -o get-docker.sh
    sudo chmod +x get-docker.sh
    sudo sh get-docker.sh
    sudo rm get-docker.sh
fi
# 配置NoVnc用户
read -p "请配置NoVnc密码: " novnc_password

# 输入启动脚本
echo "sudo docker run -d --name onebot-docker0 -e VNC_PASSWD=${novnc_password} -p 3000:3000 -p 5900:5900 -p 6081:6081 -p 3001:3001 -v ${PWD}/LiteLoader/:/opt/QQ/LiteLoader/ mlikiowa/llonebot-docker" > start.sh
echo "安装成功!下次启动执行 sudo sh ./start.sh 即可启动"

# 赋予权限
sudo chmod +x start.sh
echo "正在启动 llonebot-docker ..."
sudo sh start.sh
