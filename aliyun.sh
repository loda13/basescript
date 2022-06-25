#!/bin/bash

#配置yum源
aliyun(){
CentOS_Base_Dir="/etc/yum.repos.d/CentOS-Base.repo"
epel_dir="/etc/yum.repos.d/epel.repo"
if [ ! -f ${CentOS_Base_Dir} ] || [ ! -f ${epel_dir} ];then
  echo -e "\033[32m============================ 开始配置yum源 =============================\033[0m"
  [ ! -d /etc/yum.repos.d/bak ] && mkdir /etc/yum.repos.d/bak  
  rm -rf /etc/yum.repos.d/CentOS-Base.repo && rm -rf /etc/yum.repos.d/epel.repo
  mv /etc/yum.repos.d/* /etc/yum.repos.d/bak
  wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo
  wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
  yum clean all      #如果函数名也是yum的话，执行到这一步，又开始从头执行函数体了。
  yum makecache
  echo -e "\033[32m============================ 完成配置yum源 =============================\033[0m"
else
  echo -e "\033[32m===================== 该主机已经存在yum源，无需配置 ====================\033[0m"
fi
}

aliyun
