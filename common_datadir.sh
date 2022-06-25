#!/bin/bash

#对裸步主机做磁盘/disk1做lvm, 裸步服务的主机只需挂载/disk1
common_datadir(){
if df -h |grep /dev/mapper/vg1-lv1;then
echo -e "\033[32m================ /disk1,lvm已经制作完成，无需制作 ================\033[0m"
else
echo -e "\033[32m======================= 开始制作/disk1 lvm =======================\033[0m"
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
vgdisplay vg1 &> /dev/null
if [ $? -ne 0 ];then  
  vgcreate vg1 /dev/$11 
fi
lvdisplay /dev/vg1/lv1 &> /dev/null
if [ $? -ne 0 ];then
  lvcreate -n lv1 -l +100%FREE vg1 
fi
lvdisplay /dev/vg1/lv1 >> /dev/null
if [ $? -eq 0 ];then
  mkfs.xfs /dev/vg1/lv1    # 使用xfs文件系统 
fi
if [ ! -d /disk1 ];then
  mkdir /disk1
fi
grep '/disk1' /etc/fstab &> /dev/null
if [ $? -ne 0 ];then
  echo "/dev/vg1/lv1  /disk1  xfs  defaults 0 0"  >> /etc/fstab
  mount -a 
  df -h
fi
echo -e "\033[32m======================= 完成制作/disk1 lvm =======================\033[0m"
fi
mount -a
}

common_datadir $1 # $1 表示需要制作的盘名
