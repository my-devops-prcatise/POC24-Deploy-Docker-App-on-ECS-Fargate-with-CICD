FROM node:20-alpine

# Install curl for ECS health checks
RUN apk add --no-cache curl

WORKDIR /app

COPY package*.json ./
RUN npm install --only=production  # faster, smaller in prod
COPY . .

ENV NODE_ENV=production
ENV PORT=3000
EXPOSE 3000

# Ensure you have "start" script in package.json → "node server.js"
CMD ["npm", "start"]
