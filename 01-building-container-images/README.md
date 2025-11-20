```powershell
FROM ubuntu:latest
RUN echo 'Installing dependencies'
RUN apt update
RUN apt install nodejs npm
COPY . .
CMD [ "npm","run","dev" ]
```

Every docker runs creates a new layer.

```powershell
RUN apt update
RUN apt install nodejs npm
```

This creates two layers , so our image becomes bigger,because of docker stores but if we do below thing this will create only one layer.
That means smaller image -> faster to push/pull -> better overall performance.

```powershell
RUN apt update && apt install nodejs npm
```

Our Dockerfile.1 is like this we have to improvise it more for lesser image size

```powershell
FROM ubuntu:latest
RUN echo 'Installing dependencies'
RUN apt update && apt install nodejs npm
COPY . .
CMD [ "npm","run","dev" ]
```

So rather than using ubuntu and all these RUN commands we will do this

```powershell
FROM node:19.6-alpine
```

This will reduce the image size. We will also specify working directory

Dockerfile.2

```powershell
FROM node:19.6
WORKDIR /usr/src/app
COPY . .
RUN npm install
CMD [ "node", "index.js" ]

```

Rather than copying whole host code base we will copy only required to install depencies(better caching)
Then we will do npm install then we will copy necessary code base which will make it fast .

Dockerfile.3

```powershell
FROM node:19.6
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .
CMD [ "node", "index.js" ]

```

We will speicfy a non-root user and we will use --chown on COPY commands to set file permissions.
Then copy remaning source code for necesasry file permissons.

```powershell
USER node
```

Dockerfile.4

```powershell
FROM node:19.6-alpine
WORKDIR /usr/app/src
COPY package*.json ./
RUN npm install
USER node
COPY --chown=node:node ./src/ .
CMD [ "npm","run","dev" ]
```

We will update the Dockerfile.4 to install only production only dependencies

```powershell
RUN npm ci --only=production
```

Our updated Dockerfile.5 will look like this

```powershell
FROM node:19.6-alpine
WORKDIR /usr/app/src
COPY package*.json ./
RUN npm ci --only=production
USER node
COPY --chown=node:node ./src/ .
CMD [ "npm","run","dev" ]
```

Then we will add ENV which node uses in production
Our updated Dockerfile.6 will look like this

```powershell
FROM node:19.6-alpine
WORKDIR /usr/app/src
ENV NODE_ENV=production
COPY package*.json ./
RUN npm ci --only=production
USER node
COPY --chown=node:node ./src/ .
CMD [ "npm","run","dev" ]
```

We will cache mount to speed up existing dependecies

```powershell
RUN --mount=type=cache,target=/usr/src/app/.npm \
    npm set cache /usr/src/app/.npm && \
    npm ci --only=production

#syntax=docker/dockerfile:1.5 We also need to specify this above code because its a build
```

Our updated Dockerfile.7 will look like below

```powershell
#syntax=docker/dockerfile:1.5
FROM node:16.1-alpine
ENV NODE_ENV=production
WORKDIR /usr/app/src
COPY package*.json ./
RUN --mount=type=cache,target=/usr/app/src/.npm \
    npm set cache /usr/app/src/.npm && \
    npm ci --only=production
USER node
COPY --chown=node:node ./src/ .
CMD [ "npm","run","dev" ]
```

We will expose the port
Our updated Dockerfile.8 will look like this

```powershell
#syntax=docker/dockerfile:1.5
FROM node:16.1-alpine
ENV NODE_ENV=production
WORKDIR /usr/app/src
COPY package*.json ./
RUN --mount=type=cache,target=/usr/app/src/.npm \
    npm set cache /usr/app/src/.npm && \
    npm ci --only=production
USER node
COPY --chown=node:node ./src/
EXPOSE 3000
CMD [ "npm","run","dev" ]
```

Rather than running npm run dev as command we will run node index.js
Our updated and final Dockerfile.9 will look like this

```powershell
#syntax=docker/dockerfile:1.5
FROM node:16.1-alpine
ENV NODE_ENV=production
WORKDIR /usr/app/src
COPY package*.json ./
RUN --mount=type=cache,target=/usr/app/src/.npm \
    npm set cache /usr/app/src/.npm && \
    npm ci --only=production
USER node
COPY --chown=node:node ./src .
EXPOSE 3000
CMD [ "node","index.js" ]
```

The final Dockerfile.9 uses a smaller base image, installs only production dependencies, leverages caching, avoids unnecessary layers, and runs as a non-root user. This results in a smaller image size, faster build times, quicker pushes/pulls, improved security, and better overall runtime performance.
