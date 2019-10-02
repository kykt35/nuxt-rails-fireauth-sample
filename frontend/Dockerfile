FROM node:10.16.3-slim

WORKDIR /app

ENV PATH /app/node_modules/.bin:$PATH

RUN apt-get update && \
    apt-get install -y vim less git

ENV TZ Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ADD package.json /app/package.json

ADD . /app

RUN npm install --no-progress --registry http://registry.npmjs.org/

ENV HOST 0.0.0.0
EXPOSE 3000
 
CMD npm run start
