
## Setting 

- EC2 생성. 
    - Jenkins 전용 vm (test-subnet1) (t3.medium, 30gb)
    - Nexus 전용 vm (test-subnet2) (t2.medium, 30gb)
    - Deply 전용 vm (test-subnet3) (t3.micro, 30gb)

--> Network설정부분 다시 봐야함. 1:15:00

- Subnet 생성. 
    - Subnet1
        - 가용영역: 1a
        - 172.31.0.0/24
    - Subnet2
        - 가용영역: 2b
        - 172.31.1.0/24
    - Subnet3
        - 가용영역: 3c
        - 172.31.2.0/24

- GateWay 생성. 


### 정리. 

----
1. EC2 인스턴스를 사용할려면, Gateway를 생성하고, subnet를 생성한다음, routing table에서 각 subnet들을 연결시켜줘야함. 

2. 
----


## Jenkins EC2



