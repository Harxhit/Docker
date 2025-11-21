FROM node:20-alpine

RUN npm install

CMD ["npm", "run", "dev"]  
