FROM node:20-alpine
WORKDIR /app
COPY ["classmates chat/package*.json", "./"]
RUN npm install --production
COPY ["classmates chat/", "./"]
EXPOSE 3000
CMD ["node", "server.js"]
