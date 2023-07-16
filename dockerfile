# Use a base image with Node.js and Nginx installed
FROM node:18 AS builder

# Set the working directory
WORKDIR /app

# Copy the package.json and package-lock.json files
COPY package*.json ./

# Install project dependencies
RUN npm ci

# Copy the entire project directory
COPY . .

# Build the Angular project
RUN npm run build

# Use a new base image with Nginx
FROM nginx:1.21

# Copy the built Angular project from the previous stage
COPY --from=builder /app/dist /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start the Nginx server
CMD ["nginx", "-g", "daemon off;"]
