# ======================
# Build Stage
# ======================
FROM node:22-alpine AS builder

WORKDIR /app

# Install pnpm
RUN npm install -g pnpm

# Copy dependency files
COPY package.json pnpm-lock.yaml ./

# Install dependencies
RUN pnpm install --frozen-lockfile

# Copy source code
COPY . .

# ======================
# Production Stage
# ======================
FROM node:22-alpine

WORKDIR /app

# Install dumb-init (handle signal properly)
RUN apk add --no-cache dumb-init

# Create non-root user
RUN addgroup -g 1001 -S nodejs && adduser -S nodejs -u 1001

# Copy app from builder
COPY --from=builder --chown=nodejs:nodejs /app /app

# Create upload directories
RUN mkdir -p public/uploads/dishes public/uploads/restaurants && \
    chown -R nodejs:nodejs /app/public

# Switch to non-root user
USER nodejs

# Environment
ENV NODE_ENV=production

# Healthcheck
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
    CMD node -e "require('http').get('http://localhost:' + (process.env.PORT || 3000) + '/api/v1/home/restaurants', (r) => {if (r.statusCode !== 200) throw new Error(r.statusCode)})"

# Expose internal port
EXPOSE 3000

# Start app
ENTRYPOINT ["dumb-init", "--"]
CMD ["npm", "start"]