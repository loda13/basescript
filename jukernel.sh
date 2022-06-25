#!/bin/bash

#判断所有主机内核是否升级完成
jukernel(){
uname -r|grep 4.14 
if [ $? -ne 0 ];then
echo -e "\033[32m======================== 该主机内核未升级完成 ========================\033[0m"
exit
fi
}

jukernel
