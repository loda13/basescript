#!/bin/bash

#关闭selinux
selinux(){
echo -e "\033[32m========================== 开始禁用selinux ===========================\033[0m"
sed -i '/^SELINUX=/c\SELINUX=disabled' /etc/selinux/config
setenforce 0
[ $? -eq 0 ] && echo "selinux已关闭"
echo -e "\033[32m========================== 完成禁用selinux ===========================\033[0m"
}

selinux
