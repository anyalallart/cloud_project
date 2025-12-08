# Dockerfile for the frontend application (Node)
FROM node:18-alpine

WORKDIR /app/frontend

# install dependencies (uses package.json / package-lock.json)
COPY package*.json ./
RUN npm install

# copy application source
COPY . .

EXPOSE 3000

CMD ["npm", "start"]