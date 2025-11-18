# Gunakan Bun resmi
FROM oven/bun:1 AS base
WORKDIR /app

# Install dependencies (dengan cache)
FROM base AS deps
COPY package.json bun.lock ./
RUN bun install --frozen-lockfile

# Production dependencies only
FROM base AS prod-deps
COPY package.json bun.lock ./
RUN bun install --frozen-lockfile --production

# Build aplikasi
FROM base AS builder
COPY --from=deps /app/node_modules ./node_modules
COPY . .
ENV NODE_ENV=production
RUN bun run build

# Final image
FROM oven/bun:1 AS release
WORKDIR /app

# Copy hanya yang dibutuhkan dari .output
COPY --from=builder /app/.output ./.output

EXPOSE 3000
ENV PORT=3000
ENV HOST=0.0.0.0

USER bun
ENTRYPOINT ["bun", "run", ".output/server/index.mjs"]