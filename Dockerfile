# Stage 1: Build React App
FROM node:18 AS builder
WORKDIR /app
COPY client ./client
WORKDIR /app/client
RUN npm install
RUN npm run build

# Stage 2: Serve using Node
FROM node:18
WORKDIR /app
COPY server ./server
COPY --from=builder /app/client/build ./server/build
WORKDIR /app/server
RUN npm install
EXPOSE 5000
CMD ["node", "index.js"]
