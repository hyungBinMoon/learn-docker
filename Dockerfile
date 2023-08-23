FROM node:alpine as builder

WORKDIR /usr/src/app

COPY package.json ./

RUN npm install

COPY ./ ./

CMD [ "npm", "run", "build" ]

FROM nginx
EXPOSE 80
COPY --from=builder /usr/src/app/build /usr/share/nginx/html
# --from : 빌드된 부분 위에 from
# /usr/src/app/build : npm run build 를 하면, build 폴더 생김
# /usr/share/nginx/html : 이 안에 copy를 해야지 ngnix가 읽어들임.
