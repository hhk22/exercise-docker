
## 컨테이너 시작. 

docker run [Image]

docker create [Image]  
docker start [Container]

## RUN / CMD / ENTRYPOINT

- RUN : 도커 이미지를 빌드하는 순간에 실행되는 명령어. 
- CMD : 생성된 이미지를 실행할때 실행되는 최초 명령어. 
- ENTRYPOINT : CMD와 같지만, ENTRYPOINT는 항상 실행이되고, CMD는 변경이 가능. 

```
...
#Dockerfile
CMD ["echo", "hello"]
docker run <docker_image> echo hello world
>> hello world

#Dockerfile
ENTRYPOINT ["echo", "hello"]
docker run <docker_image> echo hello world
>> hello hello world
```

## DockerFile RUN

```
FROM node:12-alpine
RUN apk add --no-cache python3 g++ make
WORKDIR /app
COPY . .
RUN YARN install --production

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["node"]
```

```
docker run --entrypoint echo ubuntu:focal hello world
>>> docker inspect [CONTAINER]
ENTRYPOINT : ["echo"]
CMD : ["hello", "world"]
```

## Docker ENV

> docker run -it -e MY_HOST=my_name ubuntu:focal bash  
> env & echo ${MY_HOST}
----
> docker run -it --env-file ./sample.env ubuntu:focal env

## Docker EXEC

```
docker run -it -d --name my-nginx nginx
docker exec -it my-nginx bash 
```

## Docker Network

```
docker run -d -p 80:80 --name my-nginx nginx :: 0.0.0.0:80 -> :80/tcp
docker run -d -p 80 ... :: 0.0.0.0:<random_port> -> :80/tcp
docker run -d -p <local_ip>:80:80 ... :: <local_ip>:80 -> :80/tcp
```

```
// network 설정이 필요없을때 주로 사용. 
docker run -it --net none ubuntu:focal

// host network 설정을 그대로 따라갈때, 
docker run -d --network=host grafana/grafana

// bridge network
docker network create --driver=bridge example

docker run -d --network=example --net-alias=hello nginx
docker run -d --network=example --net-alias=grafana grafana/grafana

docker exec -it grafana:<container_id> bash
wget hello

docker exec -it nginx:<container_id> bash
curl grafana


// host
ifconfig

veth0
veth1
... 
bridge exmplae
docker 0
...
```

## Container Volume

```
docker run -d -v $(pwd)/html:/usr/share/nginx/html -p 80:80 nginx
```

### Volume Container

```
docker run \
    -d \
    -it \
    -v $(pwd)/html:/usr/share/nginx/html \
    --name web-volumne \
    ubuntu:focal

docker run \
    -d \
    --name example1 \
    --volumes-from web-volume \
    -p 80:80 \
    nginx

docker run \
    -d \
    --name example2 \
    --volumes-from web-volume \
    -p 80:80 \
    nginx
```

### Docker Volume

```
docker volume create --name db

docker volume ls

docker run \
    -d \
    --name example-mysql \
    -e MYSQL_DATABASE=mysql \
    -e MYSQL_ROOT_ROOT_PASSWORD=mysql \
    -v db:/var/lib/mysql \
    -p 3306:3306 \
    mysql
```


## Docker Images

### DockerFile 없이 Image 생성하기. 

```
docker run -it --name my_ubuntu ubuntu:focal
cat > test.txt "Hello world!!"
ctrl + p + q

docker commit -a <author_name> <running container name> <new image name>:<tag>
```

## docker image 경량화

- layer 수 줄이기 

```
RUN apt-get update
RUN apt-get upgrade
RUN apt-get install

>>>

RUN apt-get update && \
    apt-get upgrade && \
    apt-get install

```

- RUN 명령어에 --no-cache 옵션이 있는지 확인. 

```
RUN apk add --no-cache ... && \
    apk del --no-cache git
    ... 
```


- 베이스 이미지가 SLIM 버전과 같은 가벼운 이미지를 활용하자. 

- multi stage

```

FROM node:16-alpine AS base
LABEL maintainer="FastCampus Park <fastcampus@fastcampus.com>"
LABEL description="Simple server with Node.js"

WORKDIR /app
COPY package*.json ./


FROM base AS build
RUN npm install


FROM base AS release
COPY --from=build /app/node_modules ./node_modules
COPY . .

EXPOSE 8080
CMD [ "node", "server.js" ]

```


















