#!/bin/bash

#对k8s集群磁盘/disk1做中间件分区
k8s_datadir(){
if df -h |grep /dev/mapper/k8s-lvol0;then
echo -e "\033[32m================ 中间件数据lvm已经制作完成，无需制作 ================\033[0m"
else
echo -e "\033[32m======================= 开始制作中间件数据lvm =======================\033[0m"
lvdisplay  /dev/k8s/lvol0 &> /dev/null
if [ $? -ne 0 ];then
  lvcreate -n lvol0 -l +100%FREE k8s 
fi
lvdisplay  /dev/k8s/lvol0 &> /dev/null
if [ $? -eq 0 ];then
  mkfs.xfs /dev/k8s/lvol0 
fi
if [ ! -d /disk1 ];then
  mkdir /disk1
fi
grep '/disk1' /etc/fstab &> /dev/null
if [ $? -ne 0 ];then
  echo "/dev/k8s/lvol0  /disk1   xfs  defaults 0 0"  >> /etc/fstab
  mount -a
fi
df -h
echo -e "\033[32m======================= 完成制作中间件数据lvm =======================\033[0m"
fi
mount -a
}

k8s_datadir
