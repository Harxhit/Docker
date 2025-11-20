#syntax=docker/dockerfile:1.5

FROM node:19.6-alpine AS build

WORKDIR /usr/app/src

COPY package*.json ./

RUN --mount=type=cache,target=/usr/app/src/.npm \
    npm set cache /usr/app/src/.npm && \
    npm ci 

COPY . .

RUN npm run build

FROM nginx:1.22-alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=build /usr/app/src/dist /usr/share/nginx/html

EXPOSE 80 


