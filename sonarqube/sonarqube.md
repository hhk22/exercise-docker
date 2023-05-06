## Docker 

```
docker run --name sonarqube -d -p 9000:9000 sonarqube:latest
```

### Acount

admin / adminadmin

## Build 

### Build.gradle

```
./gradlew clean build --info

./gradlew jacocoTestCoverageVerification --info
./gradlew jacocoTestReport --info

./gradlew sonarqube --info

```
