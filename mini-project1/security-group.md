
- Common VM

    - 22(ssh)
    - 5000(tcp): nexus repository
    - 5001(tcp): nexus docker hub proxy
    - 8081(tcp): nexus web manager
    - 9000(tcp): sonarqube web manager


- Deploy VM

    - 22(ssh)
    - 8081(tcp): nexus image pull 
    - 8082(tcp): image push to aws ecr

- Jenkins VM

    - 22(ssh)
    - 8080(tcp): jenkins web

