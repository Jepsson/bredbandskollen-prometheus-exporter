# build environment
FROM node:16-buster-slim as build
WORKDIR /usr/src/app
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile --network-concurrency 10 --network-timeout 50000
COPY . ./
RUN yarn build

# production environment
FROM node:16-buster-slim
WORKDIR /usr/src/app
RUN apt-get update && apt-get install -y wget
RUN wget https://frontend.bredbandskollen.se/download/bbk_cli_linux_aarch64-1.0 && \
	mv bbk_cli_linux_aarch64-1.0 /usr/bin/bbk_cli && \
	chmod +x /usr/bin/bbk_cli
COPY --from=build /usr/src/app/dist /usr/src/app/package.json /usr/src/app/yarn.lock /usr/src/app/
RUN yarn install --production=true --network-concurrency 10 --network-timeout 50000
EXPOSE 80
ENV HTTP_PORT=80
ENV HTTP_ADDRESS=0.0.0.0
CMD ["node", "./server.js"]
