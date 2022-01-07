# A MERN Boilerplate

This project is a boilerplate for setting up a MERN full stack app. The app's folders and files are created using a single bash script.

## Usage

To use this project:
1. Clone this repository
2. Open the terminal and navigate to this directory
3. Run `sh boilApp.sh`

This will create the file structure of your full stack application, install dependencies for development and production, and fill files with starter code.

Once the setup is complete, in the same terminal window, run the following command:
### `npm run devf`

This will start a frontend development server. Navigate to localhost:9000 in your browser to see the rendered page.

Next, press CTRL+C in the terminal window to terminate the server. Run the following command to bundle your frontend:
### `npm run build`

Once the build succeeds, you are ready to serve the frontend using Node and Express. Before starting this step, you will have to create an account (free) on MongoDB. Go to https://www.mongodb.com/cloud to do so.
