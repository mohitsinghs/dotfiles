FROM ubuntu:focal

RUN apt-get update && apt-get -y upgrade && apt-get install -y sudo curl
RUN curl -fsSL sh.mohitsingh.in/essential | bash
RUN curl -fsSL sh.mohitsingh.in/shell | bash
RUN curl -fsSL sh.mohitsingh.in/node | bash
RUN curl -fsSL sh.mohitsingh.in/vim | bash

WORKDIR /root

CMD [ "zsh" ]
