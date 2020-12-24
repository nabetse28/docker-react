# This Dockerfile is for PRODUCTION ONLY
# First stage the builder of the production app

FROM node:alpine as builder 
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# /app/build is the folder that matters to the second stage  

# Second stage the server of nginx
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html

# The folder that uses the container to automatic serve an html is '/usr/share/nginx/html' 
# this is the reason why we're using that folder's path and the nginx start commnad is not
# required because an nginx container does it automatically when you create an nginx container.