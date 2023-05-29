
Subnet은 집이라고 생각하면 될것같고.... 
Routing Table은 해당 Subnet이 가야할 이정표 같은 역할. 

Routing Table에서 각 Routing마다 써야할 Subnet을 지정해줘야함. 

-- Subnet

- public-subnet-01 172.31.0.0/16  
- private-subnet-01 172.31.0.1/16

-- Security Group

- Jenkins 
    - outbound : any open
    - inbound : 22(ssh), 3128(tcp)

- Common
    - inbound : 22(ssh)(172.31.0.0/16)


-- Routing Table

- Public subnet routing
    - igw, any-open
    - local, 172.31.0.0/16

- Private subnet routing
    - any-ip -> Jenkins VM
    - local, 172.31.0.0/16


아래와 같은 squid.conf 설정 파일 생성.

```
acl SSL_ports port 443
acl Safe_ports port 80          # http
acl Safe_ports port 21          # ftp
acl Safe_ports port 443         # https
acl Safe_ports port 70          # gopher
acl Safe_ports port 210         # wais
acl Safe_ports port 1025-65535  # unregistered ports
acl Safe_ports port 280         # http-mgmt
acl Safe_ports port 488         # gss-http
acl Safe_ports port 591         # filemaker
acl Safe_ports port 777         # multiling http
acl CONNECT method CONNECT

http_access deny !Safe_ports
http_access deny CONNECT !SSL_ports

http_access allow localhost
http_access allow all

http_port 3128

coredump_dir /var/spool/squid
```

 이동. 
```
mkdir ~/squid
mv squid.conf ~/squid/
```

Squid Docker 시작. 
```
docker run --name squid -d --restart=always --publish 3128:3128 --volume <Home 디렉토리>/squid/squid.conf:/etc/squid/squid.conf--volume <Home 디렉토리>/squid/cache:/var/spool/squid sameersbn/squid:3.5.27-205Squid를활용한Private 환경Docker 빌드
```

Private VM 에서. 

```
export HTTP_PROXY=http://<Squid Proxy서버의Private IP>:3128
export HTTPS_PROXY=$HTTP_PROXY

sudo vi /etc/systemd/system/multi-user.target.wants/docker.service
>>
...
[Service]
..
Environment="HTTP_PROXY=http://<Squid Proxy서버의Private
IP>:3128"Environment="HTTPS_PROXY=http://<Squid Proxy서버의Private  IP>:3128"Environment="NO_PROXY=localhost,127.0.0.1"

sudo systemctl daemon-reload
sudo systemctl restart docker

```










