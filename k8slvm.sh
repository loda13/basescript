#!/bin/bash

#检查k8s集群 lvm是否制作完成
check_k8slvm(){
mount -a
ln=`df -h|grep k8s|wc -l`
[ $ln -eq 2 ] && echo "************k8s集群 lvm已配置************"
}

check_k8slvm
