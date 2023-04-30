
## deploy 용 EC2 준비하기. 

```
sudo apt update
sudo apt install -y docker.io
sudo apt install -y default-jdk

sudo chmod 400 /var/run/docker.sock

docker ps && docker version

sudo apt install -y awscli
```

## aws configure

- IAM 에서 사용자 생성 후, AWS Access Key ID / AWS Secret Access Key 생성. 
- 아래와 같이 aws configure 설정. 
```
aws configure
AWS Acess KEy ID: ... 
AWS Secret Access Key: ...
....


>>> 아래에 configure 정보가 저장되어 있음. 
~/.aws/credentials : ID/PW
~/.aws/config
```

- AWS ECR 생성. 
- 아래와 같은 푸시명령 실행. 

```
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 956675039632.dkr.ecr.us-east-1.amazonaws.com
>> Login Succeed
```

Manage Credentials > Stores scoped to Jenkins(System) > Global Credentials > Add Credentials > New Credentials > SSH KEY kind. > Private Key



## Github 과 연동. 

ssh-keygen 을 통해 ssh-key / ssh-key.pub 을 생성. 
github에서 Settings > Deploy keys > ssh-key.pub 내용을 등록.  
Jenkins > Manage Credentials > ssh-key 내용을 등록. 

Jenkinsfile에 아래 내용을 등록. 

```
pipeline {
    agent any 

    stages {
        stage("pull codes from github") {
            steps {
                checkout scm
            }
        }
    }
}
```

## build gradle

```
def mainDir="jenkins/2-jenkins-docker"

pipeline {
    agent any

    stages {
        stage("Build Codes by Gradle") {
            sh """
            cd ${mainDir}
            ./gradlew clean build
            """
        }
    }
}
```

## Docker Image push to AWS ECR

```
# Jenkinfile
stage('Build Docker Image by Jib & Push to AWS ECR Repository') {
    steps {
        withAWS(region:"${region}", credentials:"aws-key") {
            ecrLogin()
            sh """
                curl -O https://amazon-ecr-credential-helper-releases.s3.us-east-2.amazonaws.com/0.4.0/linux-amd64/${ecrLoginHelper}
                chmod +x ${ecrLoginHelper}
                mv ${ecrLoginHelper} /usr/local/bin/
                cd ${mainDir}
                ./gradlew jib
            """
        }
    }
}
```

```
# build.gradle

jib {
    from {
        image = 'adoptopenjdk/openjdk11:alpine-jre'
    }
    to {
        image = "956675039632.dkr.ecr.us-east-1.amazonaws.com/hyeonghwan"
        credHelper = 'ecr-login'
        tags = ['latest']
    }
    container {

        mainClass = 'com.test.StartApplication'
        jvmFlags = ['-Xms512m', '-Xmx512m', '-Xdebug', '-XshowSettings:vm', '-XX:+UnlockExperimentalVMOptions', '-XX:+UseContainerSupport']
        ports = ['8080']

        environment = [SPRING_OUTPUT_ANSI_ENABLED: "ALWAYS"]
        labels = [version:project.version, name:project.name, group:project.group]

        creationTime = 'USE_CURRENT_TIMESTAMP'
        format = 'Docker'
    }
    ...
}
```


## Deploy

```
stage('Deploy to AWS EC2 VM'){
    steps{
        sshagent(credentials : ["deploy-key"]) {
            sh "ssh -o StrictHostKeyChecking=no ubuntu@${deployHost} \
                'aws ecr get-login-password --region ${region} | docker login --username AWS --password-stdin ${ecrUrl}/${repository}; \
                docker run -d -p 80:8080 -t ${ecrUrl}/${repository}:latest'"
        }
    }
}
```