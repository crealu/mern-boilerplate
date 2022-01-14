# A MERN Boilerplate

This project is a boilerplate for setting up a MERN full stack app. The app's folders and files are created using a single bash script.

&nbsp;
## Requirements
Node v16.13.1 or later version. Node can be obtained from https://nodejs.org/en/

&nbsp;
## Usage

To use this project:
1. Clone this repository
2. Open the terminal and navigate to this directory
3. Run `sh boilApp.sh`


This will create the file structure of your full stack application, install dependencies for development and production, and fill files with a minimal amount of starter code.

Once the installation and setup are complete, in the same terminal window, run the following command:
### `npm run devf`

This will start a frontend development environment with a page rendered by React. Navigate to localhost:9000 in your browser to see the rendered page.

Next, press CTRL+C in the terminal window to terminate the dev environment. Run the following command to bundle your React app frontend and serve it from the backend using Node:
### `npm run devb`

Once the build succeeds, your frontend is ready to be served. Visit localhost:9100 in your browser window.

&nbsp;
## Connect to a database

If you would like to connect to a backend database, you will have to create an account (free) on MongoDB. Go to https://www.mongodb.com/cloud to do so. This step can be completed at the end, as well.

After creating an account and cluster, create a database and user. Obtain the connection key (MongoURI) from the MongoDB Cloud dashboard. Set this as the value for MongoURI in the keyconfig.js file. Finally, uncomment the require statements in the server.js file.

Once the database configuration is complete, start the server by typing this command into the terminal:
### `npm run devb`

You will see a message, "Database connected. Listening on 9000"

&nbsp;
## Use as a terminal command

Run the following command in the terminal to created a custom terminal command:
### `sh saveCmd.sh`

Now you can use this boilerplate in any directory in the terminal by simply typing:
### `boilApp`
