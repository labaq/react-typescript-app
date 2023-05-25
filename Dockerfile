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

# production environment
FROM nginx

RUN apt-get update
RUN apt-get -y install --assume-yes curl
#RUN apt-get -y install --assume-yes iputils-ping

# RUN rm -rf /etc/nginx/conf.d
# COPY ./docker_setting/conf /etc/nginx
COPY --from=build /app /usr/share/app
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
