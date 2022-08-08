# A MERN Boilerplate
This project contains boilerplate code and files for developing a web
application that uses MongoDB, Express, React, and Node (MERN).

&nbsp;
## Requirements
node v16.13.1 or later
npm

&nbsp;
## Usage
This project can be used as a basic structure from which a full stack web app
can be developed.
It is meant to be small with a minimal amount of boilerplate code.

&nbsp;
## Setup
1. Clone this repository
2. Open a terminal window if you haven't already
3. Navigate to `server` and run `npm install`
4. Navigate to `client` and run `npm install`

This will install all the dependencies listed in the package.json files of each
directory. Once the installations are complete, in the same terminal window,
run the following command `npm run dev`.


Navigate to localhost:8080 in your browser to see the frontend rendered by React.
The interface is being served from a Webpack dev server and updates when
changes are made to the files in `client/src`.


Next, press ctrl+C in the terminal window to terminate the open frontend environment.
Bundle your React app frontend using `npm run build`.


At this point, you could serve your frontend from node without connecting to
a Mongo database but you will need to comment out lines 8-11 in `server/server.js`.
Once you do so, you can navigate to `server` and run `npm run dev`.
Open localhost:5500 in your browser to see the application.

&nbsp;
## Connect to Mongo
In order to test that the database connection is working, you will have to create
an account (free) on MongoDB. Go to https://www.mongodb.com/cloud to do so.

After creating an account and cluster, create a database and user.
Obtain the connection string (MongoURI) from the MongoDB Cloud dashboard.
Set this string as the value for MongoURI in the `config/keys.js` file.
Finally, uncomment the require statements in the server.js file.

Once the database connection step is complete, start the server by running
`npm run dev` in the terminal window inside `server`
