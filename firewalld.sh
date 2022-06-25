#!/bin/bash

#关闭防火墙
firewalld(){
echo -e "\033[32m========================= 开始禁用firewalld ==========================\033[0m"
systemctl status firewalld 
[ $? -eq 0 ] && systemctl stop firewalld && systemctl disable firewalld && echo "防火墙已关闭"
echo -e "\033[32m========================= 完成禁用firewalld ==========================\033[0m"
}

firewalld
