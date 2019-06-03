#!/bin/bash
check_url() {
    HTTP_CODE=$(curl -o /dev/null --connect-timeout 3 -s -w "%{http_code}" $1)
    if [ $HTTP_CODE -ne 200 ]; then
        echo "Warning:$1 access failure!"
    else
	echo "$1 access sucessful."
    fi
			    }
check_url2() {
        # -T 超时时间 --tries 重试次数  --spider 爬虫模式
    if ! wget -T 10 --tries=1 --spider $1 > /dev/null 2>&1; then
            echo "Warning:$1 access failure!"
    else
	    echo "$1 access sucessful."
    fi
}
#check_url www.baidu.com
#check_url2 www.baidu.com
