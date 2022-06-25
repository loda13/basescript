#!/bin/bash

#检查防火墙是否关闭
check_fire(){
if ! systemctl status firewalld &> /dev/null;then
echo "\033[32m************防火墙已关闭************\033[0m"
else
echo "\033[32m************防火墙未关闭************\033[32m"
fi
}

#检查selinux是否关闭
check_selinux(){
if getenforce | grep forc &> /dev/null;then
echo "\033[32m************selinux未关闭************\033[0m"
else
echo "\033[32m************selinux已关闭************\033[32m"
fi
}

#检查swap是否关闭
check_swap(){
ss=`free -g|grep Swap|awk '{print $2}'`
[ $ss -eq 0 ] && echo "************swap已关闭************" || echo "************swap未关闭************"
}

#检查dns是否配置
check_dns(){
grep '114.114.114.114' /etc/resolv.conf &> /dev/null
[ $? -eq 0 ] && echo "************dns已配置************" || echo "************dns未配置************"
}

#检查yum源是否安装
check_aliyun(){
CentOS_Base_Dir="/etc/yum.repos.d/CentOS-Base.repo"
epel_dir="/etc/yum.repos.d/epel.repo"
[ -f ${CentOS_Base_Dir} ] && [ -f ${epel_dir} ] && echo "************yum源已配置************" || echo "************yum源未配置************"
}

#检查k8s集群 lvm是否制作完成
check_k8slvm(){
mount -a
ln=`df -h|grep k8s|wc -l`
[ $ln -eq 2 ] && echo "************k8s集群 lvm已配置************" || echo "************k8s集群 lvm未配置************"
}

#检查host是否配置
check_host(){
grep 'hub.iflytek.com' /etc/hosts &> /dev/null
[ $? -eq 0 ] && echo "************host已配置************" || echo "************host未配置************"
}

#检查ntpd是否安装
check_ntp(){
offset=`ntpdate -q ntp.aliyun.com|awk '{print $6}'|head -n 1|awk '{sub(/.$/,"")}1'`
offset_absolute=${offset#-}
[ $(echo "$offset_absolute > 1"|bc) -lt 1 ] && echo "************time正确************" || echo "************time错误************"
systemctl status ntpd &> /dev/null
[ $? -eq 0 ] && echo "************ntpd已安装************" || echo "************ntpd未安装************" 
}

check_fire
check_selinux
check_dns
check_swap
check_dns
check_aliyun
check_k8slvm
check_host
check_ntp
