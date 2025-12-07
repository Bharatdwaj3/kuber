# .dockerfile — FINAL ULTRA-SIMPLE PRODUCTION VERSION (no build step)
FROM node:22-alpine

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install ONLY production deps with legacy peer deps fix
RUN npm ci --only=production --legacy-peer-deps && npm cache clean --force

# Copy source code
COPY . .

# Create non-root user (k8s requirement)
RUN addgroup -g 1001 nodejs && \
    adduser -S appuser -u 1001
USER appuser

# Expose your port
EXPOSE 4000

# Direct run — no build, no bullshit
CMD ["node", "server.js"]