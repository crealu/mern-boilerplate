# A MERN Boilerplate

This project is a boilerplate for setting up a MERN full stack app. The app's folders and files are created using a single bash script.

&nbsp;
## Requirements
Node v16.13.1 or later. Node can be obtained from https://nodejs.org/en/

&nbsp;
## Usage

To use this project:
1. Clone this repository
2. Open the terminal and navigate to `app` in this directory
3. Run `npm install`

This will install all the dependencies listed in the package.json file.
Running boilAppSkel.sh will create a basic file structure for your full stack application, install the minimum dependencies required for development and production, and fill files with a minimal amount of starter code. The boilAppSkel.sh option is recommended if you would like to get started with just the fundamental components of a stack using React, Express, Node, and MongoDB.

Alternatively, running boilApp.sh will give you everything included in boilAppSkel.sh and more. This option is best for developers looking to springboard their development and
focus on fine tuning application specs that are already coded.

Once the installations are complete, in the same terminal window, run the following command:
### `npm run devf`

This will open a page that displays the frontend rendered by React. Navigate to localhost:9000 in your browser to see the rendered page.

Next, press ctrl+C in the terminal window to terminate the open frontend environment. Bundle your React app frontend and serve it with Node from the backend using the following command:
### `npm run devb`

Once the build succeeds, Node will serve the frontend and it becomes viewable. Visit localhost:9100 in your browser window to view the full stack application.

&nbsp;
## Connect to a database

If you would like to connect to a database, you will have to create an account (which is free) on MongoDB. Go to https://www.mongodb.com/cloud to do so.

After creating an account and cluster, create a database and user. Obtain the connection key (MongoURI) from the MongoDB Cloud dashboard. Set this as the value for MongoURI in the keyconfig.js file. Finally, uncomment the require statements in the server.js file.

Once the database configuration is complete, start the server by typing this command into the terminal:
### `npm run devb`

You will see a message, "Database connected. Listening on 9100"

&nbsp;
## Use as a terminal command

The saveAsCmd.sh script creates a custom terminal command that can be run in any directory from the terminal.
This created command can be used to then create a fullstack application with filled in files and installed dependencies whenever you like.
Run the following command in the terminal to create this command:
### `sh saveAsCmd.sh`

To use in any directory, run:
### `boilApp`

If you receive the error `command not found: boilApp`, you will need to change zshrc to bashrc in the saveAsCmd.sh file.
