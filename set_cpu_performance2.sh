#!/bin/bash 
set_cpu(){
        if [ -d /sys/devices/system/cpu ];then
            for i in `ls /sys/devices/system/cpu | grep 'cpu[0-9]?*'`
            do
                if [ -f /sys/devices/system/cpu/$i/cpufreq/scaling_governor ];then
                    get_cpu_stat=$(cat /sys/devices/system/cpu/$i/cpufreq/scaling_governor)
                    if [ $get_cpu_stat != 'performance' ];then
                        echo 'performance' > /sys/devices/system/cpu/$i/cpufreq/scaling_governor
                    fi
                fi
            done
}
set_cpu