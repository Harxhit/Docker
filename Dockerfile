FROM node:20-alpine

RUN npm install -y

CMD ["npm", "run", "dev"]  
