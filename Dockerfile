FROM node:16
# Installing libvips-dev for sharp Compatability
RUN apt-get update && apt-get install libvips-dev -y

ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

ENV STRAPI_TELEMETRY_DISABLED=true
ENV STRAPI_DISABLE_UPDATE_NOTIFICATION=true
ENV BROWSER=false
ENV FAST_REFRESH=false

WORKDIR /opt/
COPY ./package.json ./package-lock.json ./
ENV PATH /opt/node_modules/.bin:$PATH
RUN npm install
WORKDIR /opt/app
COPY ./ .
RUN npm run build
EXPOSE 1337
VOLUME /opt/app/public/uploads
CMD ["npm", "run", "start"]
