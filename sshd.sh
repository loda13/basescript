#!/bin/bash

#禁用登录反解析
sshd(){
echo -e "\033[32m========================= 开始禁用登录反解析 =========================\033[0m"
grep '#UseDNS yes' /etc/ssh/sshd_config  1> /dev/null
[ $? -eq 0 ] && sed -i 's/#UseDNS yes/UseDNS no/' /etc/ssh/sshd_config
grep 'GSSAPIAuthentication yes' /etc/ssh/sshd_config 1> /dev/null
[ $? -eq 0 ] && sed -i 's/GSSAPIAuthentication yes/GSSAPIAuthentication no/' /etc/ssh/sshd_config
systemctl restart sshd
echo -e "\033[32m========================= 完成禁用登录反解析 =========================\033[0m"
}

sshd
