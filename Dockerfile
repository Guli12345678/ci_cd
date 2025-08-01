FROM node:alpine AS builder
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM node:alpine
WORKDIR /app
COPY --from=builder /app/dist ./dist
COPY package.json package-lock.json ./
RUN npm ci --omit=dev
COPY . .
CMD ["node", "dist/main.js"]
