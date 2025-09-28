# Use Node.js 20 LTS as base image
FROM node:20-alpine

# Install necessary dependencies for native modules and ffmpeg
RUN apk add --no-cache \
    python3 \
    make \
    g++ \
    cairo-dev \
    jpeg-dev \
    pango-dev \
    giflib-dev \
    librsvg-dev \
    pixman-dev \
    libc6-compat \
    ffmpeg \
    git

# Create app directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies with legacy peer deps flag to handle potential conflicts
RUN npm install --legacy-peer-deps

# Copy application files
COPY . .

# Create necessary directories
RUN mkdir -p session data

# Set environment variables
ENV NODE_ENV=production

# Expose the port if your bot uses any (optional, remove if not needed)
# EXPOSE 3000

# Use the optimized start command from package.json
CMD ["npm", "run", "start:optimized"]