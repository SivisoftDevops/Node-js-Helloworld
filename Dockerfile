# Stage 0, "build-stage", based on Node.js, to build and compile the frontend
#FROM 233431242547.dkr.ecr.ap-south-1.amazonaws.com/sdx-core/node:12.14.1 as build-stage
#ARG region=prod
#WORKDIR /app
#COPY package*.json /app/
## To handle 'not get uid/gid'
#RUN export NODE_OPTIONS="--max_old_space_size=8096"
#RUN npm config set unsafe-perm true
##RUN npx npm-force-resolutions
#RUN npm install --prefer-offline --no-audit 
#
##RUN npm audit fix
#
#COPY . .
#
##RUN npm i @angular-devkit/build-angular@0.803.24
##RUN npm install angular2-query-builder@0.5.1
#RUN npm run build:$region
#RUN cp -r .well-known /app/dist/ 
#
##RUN npm run build:uat
#
## Stage 1, based on Nginx, to have only the compiled node app, ready for production with Nginx
#FROM 233431242547.dkr.ecr.ap-south-1.amazonaws.com/sdx-core/nginx:1.16.0

#COPY default.conf /etc/nginx/conf.d/default.conf
#
#COPY --from=build-stage /app/dist/ /usr/share/nginx/html
##COPY --from=build-stage /app/.well-known /usr/share/nginx/html/
#
## run nginx
#CMD ["nginx", "-g", "daemon off;"]

FROM node:4.2
COPY . /src
RUN cd /src && npm install
EXPOSE 8080
CMD ["node", "/src/server.js"]
