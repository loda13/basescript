#禁用swap
swap(){
echo -e "\033[32m============================ 开始禁用swap ============================\033[0m"
echo "vm.swappiness = 0">> /etc/sysctl.conf
swapoff -a 
sed -i '/swap/s/^/#&/' /etc/fstab
[ $? -eq 0 ] && echo "swap已关闭"
sysctl -p >> /dev/null
echo -e "\033[32m============================= 完成禁用swap ===========================\033[0m"
}

swap
