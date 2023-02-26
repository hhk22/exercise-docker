
## Docker Basic Command

```
docker pull <image name>

docker run -it --name <name> <docker_img_name> <cmd>

```


### Docker exec

```
docker run -it --name <name> <docker_img_name>
docker exec -it <name> <cmd>

>> log 
docker logs -f <docker name>

```

### Docker stop/rm/rmi

- docker stop : stop running a container
- docker rm : remove a container
- docker rmi : remove a docker image

### Upload Docker Image 

```
docker run -it -d -p 5000:5000 <img_name>
docker tag <img_name> localhost:5000/<img_name>
docker push localhost:5000/<img_name>

<docker hub>
docker login
docker tag <img_name> <hub_name>/<img_name>
docker push <hub_name>/<img_name>
```
