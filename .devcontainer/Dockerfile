FROM node:lts-slim

RUN apt-get update && apt-get install -y \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN npm i -g npm@latest mint
RUN npx skills add https://mintlify.com/docs