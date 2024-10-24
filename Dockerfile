# Use the official Bun debian image as the base image
FROM oven/bun:debian

# Set the working directory
WORKDIR /home/bots/StreamBot

# Install important deps
RUN apt-get update && apt-get install -y -qq build-essential ffmpeg python3

# Clean cache
RUN apt clean --dry-run

# Copy package.json
COPY package.json ./

# Install dependencies
RUN bun install

# Copy the rest of the application code
COPY . .

# Build the application
RUN bun run build

# Specify the port number the container should expose
EXPOSE 3000

# Create videos folder
RUN mkdir -p ./videos

# Command to run the application
CMD ["bun", "run", "start"]
