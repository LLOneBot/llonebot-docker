pkg update
pkg install wget
pkg install python3
pkg install proot
pkg install which
export UDOCKER_USE_PROOT_EXECUTABLE=$(which proot)
wget https://github.com/indigo-dc/udocker/releases/download/1.3.13/udocker-1.3.13.tar.gz
tar zxvf udocker-1.3.13.tar.gz
export PATH=`pwd`/udocker-1.3.13/udocker:$PATH
udocker install
udocker pull mlikiowa/llonebot-docker
udocker run --name=llonebot0 --env="VNC_PASSWD=vncpasswd" --publish=6081:6081 mlikiowa/llonebot-docker
