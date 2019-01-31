#!/bin/bash

# Matthew Menten - CSCI 4113 - Spring 2019

free_ram=$(free -h | awk 'FNR == 2 {print $4}')

cpu_load=$(uptime | awk -F ',' '{print $3"," $4"," $5}' | grep -o ": [0-9]*\.[0-9]*, [0-9]*\.[0-9]*, [0-9]*\.[0-9]*")

echo
echo 'CPU AND MEMORY RESOURCES -------------------------------'
echo "CPU Load Average$cpu_load    Free RAM: $free_ram"B

echo
echo 'NETWORK CONNECTIONS ------------------------------------'
lo_rec=$(cat /proc/net/dev | awk 'FNR == 4 {print $2}')
lo_tra=$(cat /proc/net/dev | awk 'FNR == 4 {print $10}')

enp_rec=$(cat /proc/net/dev | awk 'FNR == 3 {print $2}')
enp_tra=$(cat /proc/net/dev | awk 'FNR == 3 {print $10}')

echo "lo Bytes Received: $lo_rec    Bytes Transmitted: $lo_tra"
echo "enp0s3 Bytes Received: $enp_rec    Bytes Transmitted: $enp_tra"

ping -c 1 -W 1 8.8.8.8 > /dev/null
if [ $? -eq 0 ]
then
    echo Internet Connectivity: Yes
else
    echo Internet Connectivity: No
fi

echo
echo 'ACCOUNT INFORMATION ------------------------------------'
num_active=$(who | wc -l)
total_users=$(cat /etc/passwd | wc -l)

echo "Total Users: $total_users    Number Active: $num_active"
echo Shells:
shell_counts=$(cat /etc/passwd | awk -F ':' '{print $7}' | sort | uniq -c)

re='^[0-9]+$'
num=0
for line in $shell_counts
do
    if [[ $line =~ $re ]]
    then
        num=$line
    else
        echo "$line: $num"
    fi
done

echo
echo 'FILESYSTEM INFORMATION ---------------------------------'
num_files=$(find / -type f | wc -l)
num_dirs=$(find / -type d | wc -l)
echo "Total Number of Files: $num_files"
echo "Total Number of Directories: $num_dirs"

