#!/usr/bin/expect
 
# 设置永不超时
set timeout -1
spawn ssh -p 22 root@192.168.1.254
expect "*password"
send "passwd\n"
 
# 进入交互模式
interact


# 执行 expect expectSSH.sh
