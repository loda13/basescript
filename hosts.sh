#!/bin/bash

#配置本地解析
hosts(){
echo -e "\033[32m========================= 开始配置本地解析 ==========================\033[0m"
grep 'hub.iflytek.com' /etc/hosts &> /dev/null
if [ $? -ne 0 ];then
#echo '172.31.132.19   master-1
#172.31.132.37  master-2
#172.31.132.45  master-3
#172.31.132.50  node-1
#172.31.132.51  node-2
#172.31.132.57  node-3' >> /etc/hosts
echo $1 >> /etc/hosts
fi
echo -e "\033[32m========================= 完成配置本地解析 ==========================\033[0m"
}

hosts $1 
