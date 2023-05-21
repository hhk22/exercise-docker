
## Instruction.

```
docker run --name nexus -d -p 8081:8081 -p 5000:5000 --name nexus -v ~/nexus-data:/nexus-data -u root sonatype/nexus3

// login
docker login localhost:5000
username/password -> nexus account 

```

## Nexus 설정. 

- File 타입의 Blob store 생성. 
- 해당 Blob store 기반의 hosted repository 생성. (Docker, hosted)
- Settings > Realms > Docker Bearer Token Realm 을 Active 상태로 변경. 
    - Docker Login을 Nexus Account 를 이용해서 가능하도록.  
    - https://help.sonatype.com/repomanager3/nexus-repository-administration/formats/docker-registry/docker-authentication


```
docker login localhost:5000
username / password

// 외부 접근. 
// ec2에서 nexus repository 접근을 위한. repository dns 등록. 
vi ~/.docker/daemon.json

{
    "insecure-registries": [<ip-addr>:5000]
}

// restart docker here
docker info 로 확인. 

>>
...
Insecure Registries:
  <ip-addr>:5000
...

docker login <ip-addr>:5000
```


## BUILD & PUSH

```
# docker build

# build.gradle
jib {
    from {
      ...
    }
    to {
        image = '<ip-addr>:5000/<repository-name>'
        tags = ['<tag-name>']
    }
    ...

./gradlew clean build

# push to nexus repository
gradle jib -DsendCredentialsOverHttp=true --console=plain

```

## PULL

```
docker pull  ec2-44-195-33-199.compute-1.amazonaws.com:5000/test:1.0
```

## RUN
```
docker run -d -p 8080:8080 <docker image id>
```



