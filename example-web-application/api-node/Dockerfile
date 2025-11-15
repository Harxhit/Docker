#syntax=docker/dockerfile:1.5

FROM node:19.6-alpine

WORKDIR /usr/src/app

ENV NODE_ENV=production

COPY package*.json ./

RUN --mount=type=cache,target=usr/src/app/.npm \
    npm set cache /usr/src/app/.npm && \
    npm ci --only=production

COPY --chown=node:node . .

USER node

EXPOSE 3000

CMD ["node","index.js"]
