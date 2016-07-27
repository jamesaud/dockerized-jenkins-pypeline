FROM jamesaudretsch/docker-jenkins-dind:latest
 
USER root
RUN apt-get update \
	&& apt-get install -y sudo \
	&& rm -rf /var/lib/apt/lists/*
RUN sudo apt-get update \
	&& sudo apt-get install -y python3 \
	&& sudo apt-get install -y python3-pip
RUN sudo apt-get install git

RUN git clone https://github.cerner.com/JA048043/pypeline /pypeline
RUN sudo apt-get update
WORKDIR /pypeline
RUN sudo pip3 install -r requirements.txt
RUN sudo python3 setup.py install
