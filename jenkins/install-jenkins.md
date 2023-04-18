

```
mkdir -p ~/pems/jenkins
cd ~/pems/jenkins

ssh-keygen -t ed25519 -a 100 -f ssh-jenkins

```


## Git Repository SSH key 등록. 

Settings > Deploy keys > 아래 내용 등록. 

```
title : jenkins
key : ssh-jenkins.pub
```

## Jenkins Docker 실행. 

```
mkdir jenkins
docker run --name jenkins --rm -d -p 8080:8080 -v ~/jenkins:/var/jenkins_home -u root jenkins/jenkins:latest

docker exec -it jenkins bash -c "cat /var/jenkins_home/secrets/initialAdminPassword" # for check >> inital password
```

- <public_ip>:8080 접속. 
- initialPassword 입력. 
- Install Suggested Plugins 클릭. 
- ...

## Jenkins Settings

- 사용자 -> 설정 -> timezone : Asia/seoul
- Jenkins관리 -> plugin -> available plugins -> job dsl / Pipeline: Deprecated Groovy Libraries / Pipeline: Declarative Agent API / Pipeline Utility Steps / Build Pipeline / Docker / Docker Commons / Docker Pipeline / Docker API / docker-build-step / github integration / github authetication / Pipeline:Github / Gradle Repo / CloudBees AWS Credentials / Pipeline: AWS Steps / Amazon ECR / AWS Global Configuration / SSH / Publish Over SSH / SSH Pipeline Steps

- Jenkins관리 -> manage credentials -> add credentials --> ssh Username with private key -->  ssh-key 내용으로 pems/jenkins/ssh-jenkins 의 전체 내용을 입력  
ex) 
```
-----BEGIN OPENSSH PRIVATE KEY-----  
.....  .......   ..... .... .. .........  
-----END OPENSSH PRIVATE KEY-----
```

- Jenkins관리 -> aws -> add -> key등록 (aws Access key)

## Jenkins Account

```
ID: test
PW: test
```

