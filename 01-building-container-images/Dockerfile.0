FROM ubuntu:latest

RUN echo 'Installing dependencies'

RUN apt update 

RUN apt install nodejs npm

COPY . .

CMD [ "npm","run","dev" ]

