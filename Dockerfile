# Using the official Node.js Image as the base image
FROM node:18

# Setting up the work directiory for the file
WORKDIR /app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# Because if you have NPM version 4 or earlier, it will not copy the package-lock.json
COPY package*.json ./

# Bundle the app into the Docker container 
COPY . .

# Build the Node.js app 
RUN npm install

# Expose the port so it mapped into the docker
EXPOSE 3001

# Defining the  runtime system command to run the app in cmd
CMD [ "node", "app.js" ]