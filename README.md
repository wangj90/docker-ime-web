# docker-ime-web
docker构建ime软件的web服务器，针对ime软件的版本：ime_V2.0.1_Sprint4_0810

容器运行步骤：

- 将tomcat文件夹放在宿主机的某一目录下。例如：/home/wangjun/docker_volumes/ime_volumes

- 启动容器

  docker run -it --name ime-web -p 8080:8080 -v /home/wangjun/docker_volumes/ime_volumes:/u01/webimport ime-web

  1. 容器命名为ime-web；

  2. 映射宿主机的8080端口到容器的8080端口；

  3. 映射宿主机的/home/wangjun/docker_volumes/ime_volumes文件夹到容器的/u01/webimport文件夹
