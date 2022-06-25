#!/bin/bash

#对docker主机做磁盘/var/lib/docker做lvm,docker部署只需挂载/var/lib/docker
docker_imagedir(){
if df -h |grep /dev/mapper/docker-image;then
echo -e "\033[32m================ docker数据lvm已经制作完成，无需制作 ================\033[0m"
else
echo -e "\033[32m======================= 开始制作/var/lib/docker lvm =======================\033[0m"
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
vgdisplay docker &> /dev/null
if [ $? -ne 0 ];then  
  vgcreate docker /dev/$11 
fi
lvdisplay /dev/docker/image &> /dev/null
if [ $? -ne 0 ];then
  lvcreate -n image -l +100%FREE docker 
fi
lvdisplay /dev/docker/image >> /dev/null
if [ $? -eq 0 ];then
  mkfs.xfs /dev/docker/image    # 使用xfs文件系统 
fi
if [ ! -d /var/lib/docker ];then
  mkdir /var/lib/docker
fi
grep '/var/lib/docker' /etc/fstab &> /dev/null
if [ $? -ne 0 ];then
  echo "/dev/docker/image  /var/lib/docker   xfs  defaults 0 0"  >> /etc/fstab
  mount -a 
  df -h
fi
echo -e "\033[32m======================= 完成制作/var/lib/docker lvm =======================\033[0m"
fi
mount -a
}

docker_imagedir $1 # $1表示需要制作的盘名
