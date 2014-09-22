
## meta
FROM ubuntu
MAINTAINER "Joseph Werle <joseph.werle@gmail.com>"

## container dependencies
RUN apt-get update -y
RUN apt-get install -y build-essential
RUN apt-get install -y autoconf
RUN apt-get install -y libtool
RUN apt-get install -y git
RUN apt-get install -y vim
RUN apt-get install -y llvm
RUN apt-get install -y clang
RUN apt-get install -y libobjc-4.7-dev
RUN apt-get install -y libblocksruntime-dev

## mount
ADD . /home/root/libgossip

## cwd
WORKDIR /home/root

## nanomsg
RUN git clone https://github.com/nanomsg/nanomsg.git
RUN cd nanomsg && ./autogen.sh && ./configure && make && make install && ldconfig

## libgossip
RUN cd libgossip && ./configure && make

