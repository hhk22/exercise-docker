
## Install Clair

```
docker run -p 5432:5432 -d --name db arminc/clair-db:latest
docker run -p 6060:6060 --link db:postgres -d --name clair arminc/clair-local-scan:latest
```

## Install Clair-Scanner

```
wget https://github.com/arminc/clair-scanner/releases/download/v12/clair-scanner_linux_amd64

chmod+x clair-scanner_linux_amd64
sudo mv clair-scanner_linux_amd64 /usr/local/bin/clair-scanne
```

## Setting

```
export IP=$(ipr | tail -n1 | awk '{ print $9 }')
echo $IP

// 보안 취약점 검사대상 도커 이미지들. 
docker pull gradle:jdk11
docker pull bitnami/aws-cli:latest

clair-scanner --ip ${IP} --clair="http://localhost:6060"  --log="clair.log" --report="gradle_report.txt" <docker image>

ex) 
clair-scanner --ip ${IP} --clair="http://localhost:6060" --log="clair.log" --report="gradle_report.txt" bitnami/aws-cli:latest

```



