#!/bin/bash

webdir="/u01/webimport/tomcat/"
host="192.168.39.135"

# 替换MAC地址的MD5加密
macAddr=`ifconfig | grep -m 1 HWaddr | awk -F" " '{print $5}'`
oldMd5=`head -1 /u01/webimport/tomcat/webapps/ime-container/WEB-INF/classes/application.yaml | awk -F " " '{print $2}'`
newMd5=`echo -n $macAddr | md5sum |tr a-z A-Z | cut -d ' ' -f1`
echo "MAC地址为：$macAddr"
echo "MD5值为：$newMd5"
sed -i "s|$oldMd5|$newMd5|g" /u01/webimport/tomcat/webapps/ime-container/WEB-INF/classes/application.yaml

# 替换数据库连接字符串
sed -i "s|@127.0.0.1:1521:ora11g|@$host:1521:XE|g" `find /u01/webimport/tomcat/webapps/ -type f `

# 替换Index.html下服务器地址
sed -i "s|http://localhost:8080|http://$host:8080|g" /u01/webimport/tomcat/webapps/neusoftEEP_pad/index.html
sed -i "s|http://localhost:8080|http://$host:8080|g" /u01/webimport/tomcat/webapps/neusoftEEP_web/index.html

# 运行tomcat文件
if [ ! -d "$webdir" ]; then
  echo "web工程目录不存在，请将tomcat挂载到/u01/webimport下！"
else
  chmod 777 /u01/webimport/tomcat/bin/*.sh
  bash /u01/webimport/tomcat/bin/startup.sh
fi
while true; do sleep 1000; done
