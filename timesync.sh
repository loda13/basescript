#!/bin/bash

#时间同步
timesync(){
if ! ls -l /etc/localtime |grep Shanghai;then
  echo -e "\033[32m========================== 开始更改系统时区 ===========================\033[0m"
  rm -rf /etc/localtime && ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
  echo -e "\033[32m========================== 完成更改系统时区 ===========================\033[0m"
fi
systemctl status ntpd || systemctl status chronyd &> /dev/null
if [ $? -ne 0 ];then
ntpdate ntp.aliyun.com 1> /dev/null
if ! rpm -q ntp &> /dev/null; then
	echo -e "\033[32m========================== 开始安装ntpd ===========================\033[0m"
	yum -y install ntp
fi
#--------注释NTP默认配置中的默认配置问题
sed -i 's/^server 0./#&/' /etc/ntp.conf
sed -i 's/^server 1./#&/' /etc/ntp.conf
sed -i 's/^server 2./#&/' /etc/ntp.conf
sed -i 's/^server 3./#&/' /etc/ntp.conf

echo "server ntp.aliyun.com   iburst
server  127.127.1.0
fudge   127.127.1.0 stratum 8
broadcastdelay 0.008">> /etc/ntp.conf

sed -i 's/^OPTIONS/#&/' /etc/sysconfig/ntpd

#  格式处理  's/^aa/#&/' 

echo "SYNC_HWCLOCK=YES"  >> /etc/sysconfig/ntpd
echo  "OPTIONS=\"-x -u ntp:ntp -p /var/run/ntpd.pid -g\"" >> /etc/sysconfig/ntpd

#ntpdate $ntpip

clock --systohc

systemctl enable ntpd
systemctl start ntpd
fi
echo -e "\033[32m========================== 完成安装ntpd ===========================\033[0m"
}

timesync
