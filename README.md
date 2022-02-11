# A MERN Boilerplate

This project is a boilerplate for setting up a MERN full stack app. The app's folders and files are created using a single bash script.

&nbsp;
## Requirements
Node v16.13.1 or later. Node can be obtained from https://nodejs.org/en/

&nbsp;
## Usage

To use this project:
1. Clone this repository
2. Open the terminal and navigate to this directory
3. Run `sh boilAppSkel.sh` or `sh boilApp.sh`

Running boilAppSkel.sh will create a basic file structure for your full stack application, install the minimum dependencies required for development and production, and fill files with a minimal amount of starter code. The boilAppSkel.sh option is recommended if you would like to get started with just the fundamental components of a stack using React, Express, Node, and MongoDB.

Alternatively, running boilApp.sh will give you everything included in boilAppSkel.sh and more. This option is best for developers looking to springboard their development and
focus on fine tuning application specs that are already coded.

Once the installation and setup are complete, in the same terminal window, run the following command:
### `npm run devf`

This will open a page that displays the frontend rendered by React. Navigate to localhost:9000 in your browser to see the rendered page.

Next, press CTRL+C in the terminal window to terminate the frontend dev environment. Bundle your React app frontend and serve it with Node from the backend using the following command:
### `npm run devb`

Once the build succeeds, your frontend is ready to be served. Visit localhost:9100 in your browser window to view the full stack application.

&nbsp;
## Connect to a database

If you would like to connect to a backend database, you will have to create an account (free) on MongoDB. Go to https://www.mongodb.com/cloud to do so. This step can be completed at the end, as well.

After creating an account and cluster, create a database and user. Obtain the connection key (MongoURI) from the MongoDB Cloud dashboard. Set this as the value for MongoURI in the keyconfig.js file. Finally, uncomment the require statements in the server.js file.

Once the database configuration is complete, start the server by typing this command into the terminal:
### `npm run devb`

You will see a message, "Database connected. Listening on 9000"

&nbsp;
## Use as a terminal command

Run the following command in the terminal to create a custom terminal command:
### `sh saveAsCmd.sh`

Now you can use this boilerplate in any directory in the terminal by simply typing:
### `boilApp`
