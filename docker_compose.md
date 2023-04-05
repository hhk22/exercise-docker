```
docker-compose up  # create & run container
```


⠿ Network build_default   :: network build(파일명) default(bridge)  
⠿ Container build-redis-1  :: Container build(파일명) redis(서비스명) - 1 (첫번째 스케일)  
⠿ Container build-web-1    :: Container build(파일명) web(서비스명) - 1 (첫번째 스케일)  
프로젝트명을 정해주지 않으면 파일명으로 알아서 채워줌. 


```
docker-compose -p my-project up -d
docker-compsoe up --scale web=3
```


프로젝트 단위로 

```
docker-compose -p <project_name> ps
docker-compose -p <project_name> logs -f 
docker-compose -p <project_name> images
docker-compose -p <project_name> top

```

scaling out 할때 주의할점. 

```
#docker-compose.yml
...
services:
    web:
        container_name: "web" # scaling out 을 할때는 서로 name을 가져가려고 충돌함. 삭제할것. 
        ports:
            -5000:5000   # 이렇게 하면 host port 5000번을 여러 컨테이너가 사용할려고 충돌함. 
            -5000 # scaling out 을 위해선 이와 같이 사용해야함
            # ###1:5000
            # ###2:5000
            ...

```

docker compose 에서 실행 순서를 정할 수 있음. 

```
#docker-compose.yml

services:
    db:
        ... 
    
    wordpress:
        depends_on:
            db # db 서비스가 시작되고 나서 해당 서비스(wordpress)를 실행해라. 
            # 주의 : db 서비스가 시작되었음은 보장되지만, 준비되었는지는 보장하지 않음. 

```

