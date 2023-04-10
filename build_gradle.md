
## Installation

```
sudo apt -y install apt-transport-https dirmngr software-properties-common
sudo add-apt-repository ppa:cwchien/gradle  # gradle 7.0 required

sudo apt update
sudo apt install -y gradle

```

## Build Gradle Project

```
gradle init --dsl=groovy --type=java-application --test-framework=junit --package=com.test --project-name=test-docker-spring-boot

gradle build --info

```

## Build Image with Jib

```
#build.gradle

plugins{
    ...
    id 'com.google.cloud.tools.jib' version '3.3.1'
}

...

jib {
  from {
    image = 'adoptopenjdk/openjdk11:alpine-jre'
  }
  to {
    image = '<Docker Hub Repository URL>'
    tags = ['<TAG Name>']
  }
  ...
  ports = ['8080']
  ...

}
```

## Gradle Build and Push

```

./gradlew clean build --info  # build

>> to container image (without docker)

./gradlew jib

#### pull image
docker pull <user_name>/<img>:<tag>
>> docker로 올렸을때 보다 jib을 통한 이미지가 훨씬 더 가벼움. 

```


