#!/bin/bash

#永久配置dns
dns(){
echo -e "\033[32m============================ 开始配置dns =============================\033[0m"
grep 'nameserver 114.114.114.114' /etc/resolv.conf 
[ $? -ne 0 ] && echo 'nameserver 114.114.114.114' >> /etc/resolv.conf 
grep 'search' /etc/resolv.conf
[ $? -eq 0 ] && sed -i '/search/s/^/#&/' /etc/resolv.conf
chattr +i /etc/resolv.conf
echo -e "\033[32m============================ 完成配置dns =============================\033[0m"
}

dns
