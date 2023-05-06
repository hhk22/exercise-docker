## Repository Type 

1. Proxy Repository  
 원격 저장소를 미러링하는 저장소. 
2. Host Repository   
 프라이빗 저장소. 호스트 저장소에서만 업로드가 가능하다. 
3. Virtual Repository  
 서로 다른타의 Repository를 연결하는 어댑터 역할. 
4. Group Repository   
 여러종류의 저장소를 논리적으로 하나로 묶어서 사용할 수 있는 기능. 

## Docker 

```
docker run --name nexus -d -p 8081:8081 -v ~/nexus-data:/nexus-data -u root sonatype/nexus3

#Admin Password
docker exec -it nexus bash -c "cat /nexus-data/admin.password"
```

## Gradle에서 Repository를 Nexus로 설정.

```
respositories {
    mavenCentral()
}

>> 

respositories {
    maven {
        url "https://<Nexus-public-ip>:8081/repository/<Nexus-repo-name>"
    }

}
```

## Build

```
gradle clean build --info


// [Optional] nexus cache를 확인하기 위해. 
rm ~/.gradle/caches/*  // (nexus cache 속도 비교를 위해 지우고)
gradle clean build --info // nexus cache를 이용한 빌드. --> 훨씬 빨라짐. 


aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 956675039632.dkr.ecr.us-east-1.amazonaws.com


gradle jib --console=plain

docker run -d --rm -p 8080:8080 <AWS ECR URL>/<TAG> 

```

