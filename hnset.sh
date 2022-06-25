#!/bin/bash

#修改主机名
hnset(){
echo -e "\033[32m========================= 开始修改主机名 ==========================\033[0m"
ip=`ifconfig $1 | grep 'inet ' | awk '{print $2}'` 1>/dev/null
hostname=`cat /etc/hosts | grep $ip | awk '{print $2}'|grep -v hub.iflytek.com` 1>/dev/null
hostnamectl set-hostname --static $hostname
echo -e "\033[32m========================= 完成修改主机名 ==========================\033[0m"
}

hnset $1
