# Step 1: Build the React application
FROM node:16 AS build

WORKDIR /app
COPY package.json ./
COPY yarn.lock ./
RUN yarn install
COPY . ./
RUN yarn build

# Step 2: Serve the React application using NGINX
FROM nginx:alpine

COPY --from=build /app/build /usr/share/nginx/html

# Expose the port the app will run on
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
