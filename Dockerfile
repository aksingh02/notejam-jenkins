FROM node:latest

WORKDIR /usr/db

COPY . .

RUN npm install

RUN node db.js

EXPOSE 3000

CMD ["npm", "start"]
