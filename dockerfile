# Step 1: Build the React App
FROM node:18-alpine AS build

WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build

# Step 2: Serve with Nginx
FROM nginx:alpine

# Copy the React build to Nginx's public directory
COPY --from=build /app/build /usr/share/nginx/html

# Remove the default Nginx config
RUN rm /etc/nginx/conf.d/default.conf

# Replace with a custom config (optional if needed)
# COPY nginx.conf /etc/nginx/conf.d

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
