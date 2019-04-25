#FROM keymetrics/pm2:latest-alpine
#
#MAINTAINER ilovintit <ilovintit@gmail.com>

FROM node:latest

RUN npm install pm2 -g

#部署代码
RUN mkdir -p /app
WORKDIR /app
COPY ./package.json /app/
COPY ./package-lock.json /app/
RUN npm install --production
COPY . /app
ENV NODE_ENV=production
ENV HOST=0.0.0.0
RUN npm run build

EXPOSE 80

CMD [ "pm2-runtime", "start", "/app/ecosystem.config.js" ]
