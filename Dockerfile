# Use Ubuntu base image with build tools
FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    nodejs \
    npm \
    gcc \
    flex \
    bison \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install Node.js dependencies
RUN npm install

# Copy all project files
COPY . .

# Build the compiler (Linux binary named 'app' without .exe)
RUN bison -d parser.y && \
    flex scanner.l && \
    gcc -o app parser.tab.c lex.yy.c -lm

# Make sure app is executable
RUN chmod +x app

# Expose port
EXPOSE 3000

# Start the server
CMD ["node", "server.js"]
