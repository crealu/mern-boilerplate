const path = require('path');
const express = require('express');
const router = express.Router();
const pathToBuild = path.join(__dirname, '../client/build');

router.use(express.static(pathToBuild));

router.get('/', (req, res) => {
  res.sendFile('index.html', {root: './build'});
});

module.exports = router;
