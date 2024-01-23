FROM node:20 as build
WORKDIR /app
COPY package*.json ./
RUN npm ci --omit=dev
#RUN npm install --only=production 

FROM gcr.io/distroless/nodejs20-debian11
COPY --from=build /app /app
WORKDIR /app
COPY . .
EXPOSE 3000
CMD ["./bin/www"]