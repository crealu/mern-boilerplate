# A MERN Boilerplate

This project is a boilerplate for setting up a MERN full stack app. The app's folders and files are created using a single bash script.

&nbsp;
## Requirements
Node v16.13.1 or later
https://nodejs.org/en/

&nbsp;
## Usage

To use this project:
1. Clone this repository
2. Open the terminal and navigate to `app` in this directory
3. Run `npm install`

This will install all the dependencies listed in the package.json file. Once the installations are complete, in the same terminal window, run the following command:
### `npm run devf`

Navigate to localhost:9000 in your browser to see the frontend rendered by React.
The interface is being served from a Webpack dev server and updates when
changes are made to the files in `app/src`. As an experiment, change the color
in style.css to `lightblue`.

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
This created command can be used to then create a full stack application with filled in files and installed dependencies whenever you like.
Run the following command in the terminal to create this command:
### `sh createTerminalCommand.sh`

To use in any directory, run:
### `generateApp`

If you receive the error `command not found: generateApp`, you will need to change zshrc to bashrc in the createTerminalCommand.sh file.
