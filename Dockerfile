FROM debian:jessie

MAINTAINER Paolo Di Tommaso 


RUN apt-get update \
 && apt-get install clustalw raxml