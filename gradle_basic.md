## Gradle File System. 

- ./build/* : build 결과물. 
- ./gradle/wrapper/* : package-lock.json 과 같은 설치된 gradle 버전과 package들의 list들을 저장해놓은 곳. 


## 간단한 프로젝트 실행. 

```
gradle init
mkdir -p src/main/java/hello
```

```
vi src/main/java/hello/HelloWorld.java
package hello;

public class HelloWorld {
  public static void main(String[] args) {
    System.out.println("hello world!");
  }
}
```

```
vi build.gradle
apply plugin: 'application'
mainClassName = 'hello.HelloWorld'
./gradlew run
```

## Build.gradle

- buildscript : 보통 별도의 외부 라이브러리를 따로 가져올때 사용합니다. 
ex) 
```
buildscript {
    repositories {
        ...
    }
    dependencies {
        ...
    }
}
```

- plugins vs apply plugin  
plugins : The plugins block has a more concise syntax and is recommended for use (버전 특정 가능. )
apply plugin : more verbose and can be used in any version of Gradle

```
plugins {
    id 'org.springframework.boot' version '2.5.2'
}

apply plugin org.springframework.boot
```

## Task 

```
#build.gradle

hello {
    println("Hi Hello world")
}

>> ./gradlew hello
"Hi Hello world"
```

