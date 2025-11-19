# Use Bun official image
FROM oven/bun:1 AS base
WORKDIR /app

# Install dependencies with cache
FROM base AS deps
COPY package.json bun.lock ./
RUN bun install --frozen-lockfile

# Install production dependencies only
FROM base AS prod-deps
COPY package.json bun.lock ./
RUN bun install --frozen-lockfile --production

# Build production
FROM base AS builder
COPY --from=deps /app/node_modules ./node_modules
COPY . .
ENV NODE_ENV=production
RUN bun run build

# Final image
FROM oven/bun:1 AS release
WORKDIR /app

# Only copy .output folder
COPY --from=builder /app/.output ./.output

EXPOSE 3000
ENV PORT=3000
ENV HOST=0.0.0.0

USER bun
ENTRYPOINT ["bun", "run", ".output/server/index.mjs"]