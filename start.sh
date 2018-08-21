#!/bin/bash

activationfile="/ActivationCode.class"
webdir="/u01/webimport/tomcat/"
host="192.168.39.135"

# 替换License
if [ -f "$activationfile" ]; then
  oldCompany=`cat /u01/webimport/tomcat/webapps/ime-container/WEB-INF/classes/application.yaml | grep lien.company | awk -F " " '{print $2}'`
  oldContext=`cat /u01/webimport/tomcat/webapps/ime-container/WEB-INF/classes/application.yaml | grep lien.context | awk -F " " '{print $2}'`
  newCompany="wangjun"
  newContext=`java -cp / ActivationCode`
  sed -i "s|$oldCompany|$newCompany|g" /u01/webimport/tomcat/webapps/ime-container/WEB-INF/classes/application.yaml
  sed -i "s|$oldContext|$newContext|g" /u01/webimport/tomcat/webapps/ime-container/WEB-INF/classes/application.yaml
  # 删除java的二进制文件
  rm /ActivationCode.class
fi

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
