FROM node:18-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install --only=production 
RUN chown node:node /app
USER node
COPY --chown=node:node  . .
EXPOSE 3000
CMD ["node", "./bin/www"]