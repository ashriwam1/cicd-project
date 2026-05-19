# ─────────────────────────────────────────
#  Stage 1 – Build & install dependencies
# ─────────────────────────────────────────
FROM node:18-alpine AS builder

WORKDIR /usr/src/app

# Copy only package files first (layer cache optimisation)
COPY app/package*.json ./

RUN npm install --production

# ─────────────────────────────────────────
#  Stage 2 – Final lightweight image
# ─────────────────────────────────────────
FROM node:18-alpine

WORKDIR /usr/src/app

# Copy installed node_modules from builder
COPY --from=builder /usr/src/app/node_modules ./node_modules

# Copy application source
COPY app/ .

# Expose app port
EXPOSE 3000

# Health-check so Docker/Jenkins can verify the container is live
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD wget -qO- http://localhost:3000/api/health || exit 1

# Run app
CMD ["node", "index.js"]
