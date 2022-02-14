## Build phase
FROM node:17-alpine as builder 

WORKDIR '/app'

# we need to run npm, so we need the dependencies from package.json
COPY package.json . 
RUN npm install -g npm@8.4.0

COPY . .
# RUN mkdir -p node_modules/.cache && chmod -R 777 node_modules/.cache

RUN npm run build

# /app/build <---- all the build

## Run phase
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html

