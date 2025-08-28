# Use Node.js Alpine as base image
FROM node:20-alpine AS base

# Install pnpm globally
RUN corepack enable pnpm

# Set working directory
WORKDIR /app

# Copy package files
COPY package.json pnpm-lock.yaml ./

# Install dependencies
FROM base AS dependencies
RUN pnpm install --frozen-lockfile

# Build stage
FROM base AS build
COPY --from=dependencies /app/node_modules ./node_modules
COPY . .
RUN pnpm build

# Production stage
FROM node:20-alpine AS production
WORKDIR /app

# Install pnpm
RUN corepack enable pnpm

# Copy built application
COPY --from=build /app/.next/standalone ./
COPY --from=build /app/.next/static ./.next/static
COPY --from=build /app/public ./public

# Expose port
EXPOSE 3000

# Start the application
CMD ["node", "server.js"]