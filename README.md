

## Creating Node.js web app with Docker

Creating [Node.js](https://nodejs.org/en) app with [Docker](https://www.docker.com/) (or we can call it "Dockerizing Node.js app) can be a win-win solution for every software engineers, developers, students, etc, because of the _"it can be opened everywhere"_ trait, as long as the Docker installed within the Hardware. Before we jump into detail about creating and running this Node.js app with Docker, there are two general steps on how we are going to Dockerize the Node.js web app. 

First thing first, we need to virtualized docker by installing Windows Subsystem for Linux (WSL) and [Docker](https://www.docker.com/). And the second part is creating Dockerizing the Node.js web app. In this case we will create images with an existing app that have already provided by my instructor.

## 🐳 Installing Docker 
1. Download [Docker](https://https://www.docker.com/).
2. Double click on __Docker Desktop Installer.exe__ to install the application.
3. Click next to continue the installation.
4. Wait until the installation is finished.
5. Restart your PC to complete the installation process.
6. Open your Terminal (ex : Windows Powershell) and run it as an administrator.
Or you can press __Windows + R__ on your keyboard and type `powershell`.
7. Type `docker --version` to check the Dcoker version and your installation is complete.

## 🖥️ Installing Windows Subsytem for Linux
1. Open your terminal (ex : Windows Powershell) and run it as an administrator.
Or you can press __Windows + R__ on your keyboard and type `powershell`.

2. type `wsl --install` to start installing your Windows Subsystem for Linux.
3. Wait until the installation is finished.
4. You can enable WSL using one of the two methods, from __Control Panel__ or using Terminal.
- From Control Panel : 
    - open Start -> Control Panel -> All Control Panel Items -> Programs and Features -> Turn Windows features on or off, find and check Windows Subsystem for Linux and Virtual Machine Platform.
- With Terminal :
    - `Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux`
    - `Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform`
5. Restart your PC to complete the installation process.
6. Verify your WSL installation by typing `wsl --status` to check your WSL status and `wsl --version` to verify your wsl version.
7. Your WSL is complete and ready to use.

## 👨‍💻 Dockerizing Node.js App

Like i said above, in this example we are not going to create a new node.js app, so we will use an existing code that you can download it __[HERE](https://gist.github.com/berdoezt/e51718982926f0caa3fcd8ed45111430)__. And we will use it later in this step.


### 1. Create Package.json
1. Create a new directory to store all of your files. You can do it by 
- default using _File Explorer_ and go to your preferred destination, and create a new folder by right clicking your mouse and then create new folder 
- you can open your favourite terminal and type `cd <folder destination>` to change the directory and then type `mkdir <folder name>` to create a new folder.
2. Open your IDE (ex : Visual Studio Code), open folder from your recent directory you have created.
3. Create a new _package.json_ file to describe the app, it shows like in the code block below.
```
{
    "name": "docker-nodejs-app",
    "version": "1.0.0",
    "description": "assignment 6 : Docker on NodeJs app",
    "author": "Dody Hartanto <muharridody@gmail.com>",
    "main": "app.js",
    "scripts": 
    {
      "start": "node app.js"
    }
}
```
Here is a brief explanation of the code
| Object | Property |
| ----------- | ----------- |
| name | name of the app |
| version | version release of the app |
| description | description of the app |
| author | author of the app |
| scripts | collection of script include in the package |
| start | runtime to start the app |

4. With your new _package.json_ file you have created, type `npm install`.
5. It will create a _package-lock.json_ file that will copied to your Docker image.


### 2. Create Dockerfile
1. Still in the same directory with the _package.json_ and _package-lock.json_ file, create _Dockerfile_ using one of these methods :
- Using Powershell : `<directory>/Dockerfile -ItemType File`.
- Inside Virtual Studio Code folder by hovering the folder name and clink new file.
2. Inside the Dockerfile, type like the code block below. The description will be shown before the code block.
| Syntax | Explanation | 
| ----------- | ----------- |
| FROM | Choosing the base image to build |
| WORKDIR | A directory to hold the application code inside the image |
| COPY | To bundle your app's source code inside the Docker image | 
| RUN | Syntax to run the code, it depend on the language | 
| EXPOSE | To expose the port so it mapped into the docker |
| CMD | Defining the  runtime system command to run the app in cmd |


- Using the latest LTS (long term support) version ___18___ of ___node___ 
`FROM node:18` 

- Creating directory _/app_ as the working directory
`WORKDIR /app`

- To ensure the _package-lock.json_ copied into the image when the installed npm is version 4 or earlier, because it will not generate _package-lock.json_.
`COPY package*.json ./`

- Using . to select all files inside the directory.
`COPY . .`

- To execute the ___Node.js app we've already downloaded___.
`RUN npm install`

- Using 3001 because the port that used in the app.js is 3001
`EXPOSE 3001`

- Choosing the runtime syntax is simply because it uses node and the name of the app is app.js 
`CMD [ "node", "app.js" ]`

The file will be like this.
```
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
```
3. Save the file, and the last file is done. 

### Build and Run the app.js Image
1. Open your preferred terminal.
2. Build the image by typing `docker build . -t <your username>/<app name>`.
3. After finished building the image, check your image by typing `docker images`.
4. Run it by typing `docker run -p <choose your port>:3001 -d <your username>/<app-name>`.
5. Open your browser, and type localhost:<your port that you have chosen when running the app>. For example like the picture below.