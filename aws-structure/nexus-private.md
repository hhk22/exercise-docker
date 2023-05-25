
-- NAT Gateway
VPC의 리소스와 인터넷 간의 통신을 활성화하기 위해 VPC에 연결하는 게이트웨이이다.

-- Subnet  
VPC의 IP 주소 범위. VPC를 잘개 쪼개는 과정이다. 

-- Route table
데이터가 라우터로 향하도록 알려주는 이정표이다


-- Instance 

1. instance 01 : test-private-deploy

2. instance 02 : test-jenkins (bastion)

3. instance 03 : test-nexus-common


-- 실습환경 구축. 

- Public Subnet2, Private Subnet 1 라우팅 생성 --> Internet Gateway 추가. 
- NatGateway 생성, --> Public Subnet2내에 생성(IP 자동할당.)
- Private Subnet2 --> NatGateway 연결. 
