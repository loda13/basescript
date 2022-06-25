#!/bin/bash

#内核参数优化
ker_opt(){
echo -e "\033[32m==================== 修改内核参数优化 ====================\033[0m"
echo 'vm.swappiness = 0
fs.file-max = 12553500
fs.nr_open = 12453500
kernel.shmall = 4294967296
kernel.shmmax = 68719476736
kernel.msgmax = 65536
kernel.pid_max = 65536
net.core.netdev_max_backlog = 2000000
net.core.rmem_default = 699040
net.core.rmem_max = 50331648
net.core.wmem_default = 131072
net.core.wmem_max = 33554432
net.core.somaxconn = 65535
vm.max_map_count=262144
net.ipv4.ip_forward = 1
net.ipv4.ip_local_port_range = 1025 65534
net.ipv4.ip_nonlocal_bind = 1
net.ipv4.tcp_fin_timeout = 7
net.ipv4.tcp_max_orphans = 3276800
net.ipv4.tcp_max_syn_backlog = 655360
net.ipv4.tcp_max_tw_buckets = 6000000
net.ipv4.tcp_mem = 94500000 915000000 927000000
net.ipv4.tcp_rmem = 32768 699040 50331648
net.ipv4.tcp_wmem = 32768 131072 33554432
net.ipv4.tcp_slow_start_after_idle = 0
net.ipv4.tcp_synack_retries = 2
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_tw_recycle = 1
net.ipv4.tcp_tw_reuse = 1' > /etc/sysctl.conf

ker_recycle=`uname -r|awk -F'.' '{print $1}'`
[ ${ker_recycle} -gt 3 ] && sed -i '/net.ipv4.tcp_tw_recycle/s/^/#&/' /etc/sysctl.conf    #内核4.10已放弃该参数

sed -i 's/^[^#]/#&/' /etc/security/limits.conf     # 注释未注释内容
[ -d /etc/security/limits.d ] && sed -i 's/^[^#]/#&/' /etc/security/limits.d/*

echo '* soft nofile 6553500
* hard nofile 6553500
* soft nproc 655350
* hard nproc 655350

* soft memlock unlimited
* hard memlock unlimited' >> /etc/security/limits.conf

[ -d /etc/security/limits.d ] && sed -i 's/^[^#]/#&/' /etc/security/limits.d/*
sysctl -p
}

ker_opt
