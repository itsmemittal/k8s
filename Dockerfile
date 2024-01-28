FROM node:14.17-alpine AS BUILD_IMAGE
WORKDIR /usr/src/app

RUN apk add --no-cache openjdk8
RUN apk add bash

RUN mkdir /usr/src/app/liquibase
RUN wget https://github.com/liquibase/liquibase/releases/download/v4.11.0/liquibase-4.11.0.tar.gz -P /usr/src/app/liquibase
RUN tar -xvf /usr/src/app/liquibase/liquibase-4.11.0.tar.gz -C /usr/src/app/liquibase
RUN export PATH=$PATH:/usr/src/app/liquibase/liquibase
RUN ln -s /usr/src/app/liquibase/liquibase /usr/bin/liquibase

COPY package.json ./
RUN npm install
COPY . .
RUN npm run build

EXPOSE 8002
EXPOSE 4002
CMD ["npm","run", "start:development"]