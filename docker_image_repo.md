
## private repo에 image 올리기. 

```
docker tag nginx:latest <yourname>:<your_repo>:<yourtag>
>> docker tag nginx:latest hyeonghwan:my-nginx:v1.0.0

docker push hyeonghwan/my-nginx:v1.0.0
```

## aws ecr repo에 image 올리기. 

```
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <...>

docker tag hyeonghwan:latest <...>

docker push <...>
```

