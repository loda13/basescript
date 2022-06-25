#!/bin/bash

#对k8s集群磁盘做/var/lib/docker目录做lvm
k8s_imagedir(){
if df -h |grep /dev/mapper/k8s-docker;then
echo -e "\033[32m================ k8s集群，docker数据lvm已经制作完成，无需制作 ================\033[0m"
else
echo -e "\033[32m======================= 开始对k8s集群制作docker数据lvm =======================\033[0m"
fdisk -l /dev/$11 1> /dev/null
if [ $? -ne 0 ];then
fdisk /dev/$1 << EOF
n
p
1
2048
  
w
EOF
fi
if ! rpm -q lvm2 &> /dev/null; then
  yum -y install lvm2 &> /dev/null
fi
if rpm -q lvm2 &> /dev/null;then
  pvdisplay /dev/$11 &> /dev/null
  if [  $? -ne 0 ];then
    pvcreate /dev/$11 
  fi
fi
vgdisplay k8s &> /dev/null
if [ $? -ne 0 ];then  
  vgcreate k8s /dev/$11 
fi
lvdisplay /dev/k8s/docker &> /dev/null
if [ $? -ne 0 ];then
  lvcreate -n docker -L $2G k8s 
fi
lvdisplay /dev/k8s/docker >> /dev/null
if [ $? -eq 0 ];then
  mkfs.xfs /dev/k8s/docker 
fi
if [ ! -d /var/lib/docker ];then
  mkdir /var/lib/docker
fi
grep '/var/lib/docker' /etc/fstab &> /dev/null
if [ $? -ne 0 ];then
  echo "/dev/k8s/docker  /var/lib/docker   xfs  defaults 0 0"  >> /etc/fstab
  mount -a 
  df -h
fi
mount -a
echo -e "\033[32m======================= 完成制作k8s集群image数据lvm =======================\033[0m"
fi
}

k8s_imagedir $1 $2    # $1表示需要制作的盘名，$2表示分给/var/lib/docker目录的大小
