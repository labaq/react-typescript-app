# build environment
FROM node:18 as build
WORKDIR /app

ENV PATH /node_modules/.bin:$PATH
WORKDIR /app
#COPY ./.env.* /app/
#COPY ./yarn.lock /app/
COPY ./package*.json /app/
#COPY ./docker_setting/web.backoffice/nginx.conf /app/

RUN yarn install
#RUN yarn global add react-scripts@2.1.8 -g
COPY . /app

RUN yarn run build