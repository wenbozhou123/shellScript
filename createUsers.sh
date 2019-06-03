#!/bin/bash
DATE=$(date +%F_%T)
USER_FILE=user.txt
function echo_color(){
    if [ $1 == "green" ];then
        echo -e "\033[32;40m$2\033[0m"
    elif [ $1 == "red" ]; then
	echo -e "\033[31;40m$2\033[0m"
    fi
}

# 若用户文件存在且大小不为0则备份
if [ -s ${USER_FILE} ]; then
	mv ${USER_FILE} ${USER_FILE}-${DATE}.bak
	echo_color green "${USER_FILE} exist, rename ${USER_FILE}-${DATE}.bak"
fi

# 创建用户并将用户名密码保存至文件
echo -e "User\tPassword" >> ${USER_FILE}
echo -e "--------------" >> ${USER_FILE}

for USER in user{1..5}; do
	if ! id ${USER} &>/dev/null; then
		PASS=$(echo $RANDOM | md5sum | cut -c 1-8)
		useradd $USER
		echo $PASS | passwd --stdin $USER &>/dev/null
		echo -e "$USER\t$PASS" >> $USER_FILE
		echo "$USER create sucessful."
	else
		echo_color red "$USER already exist!"
	fi
done

