FROM ubuntu:18.04

RUN apt-get update

WORKDIR /home/hh/

RUN echo "This is text file" >> test.txt

CMD ["cat", "test.txt"]

