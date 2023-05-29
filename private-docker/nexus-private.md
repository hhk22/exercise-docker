
## NEXUS private repo

docker file에 해당 내용 추가. 

```
RUN chown -R nexus:nexus ${NEXUS_HOME}/etc \
    && sed '/^application-port/s:$:\napplication-port-ssl=8443:' -i ${NEXUS_HOME}/etc/nexus-default.properties \
    && sed '/^nexus-args/s:$:,${jetty.etc}/jetty-https.xml:' -i ${NEXUS_HOME}/etc/nexus-default.properties \
    && rm -rf ${NEXUS_HOME}/etc/ssl && ln -s ${NEXUS_DATA}/etc/ssl ${NEXUS_HOME}/etc/ssl

... 

EXPOSE 8443
```

그다음에 해당 정보를 이용해서 keytool 을 이용해 생성하는 shell 파일 실행. 

```
#! /bin/bash

if [ ! -e "$NEXUS_DATA/etc/ssl/keystore.jks" ]; then
mkdir -p "$NEXUS_DATA/etc/ssl"
chmod go-rwx "$NEXUS_DATA/etc/ssl"
keytool -genkeypair -keystore $NEXUS_DATA/etc/ssl/keystore.jks -storepass password -keypass password \
        -alias jetty -keyalg RSA -keysize 2048 -validity 5000 \
        -dname "CN=*.${HOSTNAME}, OU=FastCampus, O=FastCampus, L=Gangnam, ST=Seoul, C=KR" \
        -ext "SAN=DNS:${SAN_DNS}" -ext "BC=ca:true"
fi

sh -c ${SONATYPE_DIR}/start-nexus-repository-manager.sh
```

docker 실행시, 다음과 같으 SAN_DNS 변수를 넣어줘야함. 


```
 docker run -d -u root --net=host -e SAN_DNS=<Private DNS> --name nexus -v ~/nexus-data:/nexus-data  fastcampus-nexus3:3.32.0
```

인증서 export && import

```
docker exec nexus keytool -printcert -sslserver 127.0.0.1:8443 -rfc | tee nexus.
>> 다른 vm 에서는 nexus.crt부분을 복사해서 아래부분 실행하면 됨. 

sudo cp -av nexus.crt  /usr/local/share/ca-certificates/nexus.crt
sudo upate-ca-certificates
sudo mkdir /etc/docker/certs.d/<Nexus VM의프라이빗ip dns 이름>\:5443/ -p
sudo cp -av nexus.crt /etc/docker/certs.d/<Nexus VM의프라이빗ip dns 이름>\:5443/ca.crt
```

그다음 nexus manager에서 repository를 만들때, 5443port(https)로 접속하게 만들면 된다. 

docker login 부분. 


```
// Nexus Docker Registry login
docker login -u '<Nexus 로그인계정ID>'-p '<Nexus 로그인계정Password>'https://<Nexus VM의프라이빗IP DNS 이름>:5443

// docker hub 에 관한 부분도. 5443 port대신에 5001 port 로 대신 수행. 
sudo mkdir /etc/docker/certs.d/<Nexus VM의프라이빗ip dns 이름>\:5001/ -p
sudo cp -av nexus.crt /etc/docker/certs.d/<Nexus VM의프라이빗ip dns 이름>\:5001/ca.crt
docker login -u '<Nexus 로그인계정ID>'-p '<Nexus 로그인계정Password>'https://<Nexus VM의프라이빗IP DNS 이름>:5001
```




