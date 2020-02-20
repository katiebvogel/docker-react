# for production environment, we have a 2-phase docker configuration

FROM node:alpine as builder 
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build 

# /app/build <---- has all the stuff we want to serve up in run phase

FROM nginx
# expose 80 is for AWS ElasticBeanstalk
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html

