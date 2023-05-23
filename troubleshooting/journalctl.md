
```
journal ctl -r -u docker 
-r : 내림차순, -u : define specific docker. 

docker info 

docker inspect <container_id>

docker logs <conatiner_id>

```

```
# tcp packet 파일을 통한 분석. 

sudo tcpdump -i docker0 -w tcpdump.pcap
>> wireshark 를 통해서 파일을 분석.  

몇가지 문법. 
> http
> tcp.dstport == 80
> tcp.port == 80 and ip.addr = <specific ip>
> http.response.code == 200 

developer guide 
> https://www.wireshark.org/docs/wsdg_html_chunked/
```




