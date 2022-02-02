const path = require('path');

module.exports = {
  entry: './frontend/index.js',
  output: {
    filename: 'www/assets/main.js',
    path: path.resolve(__dirname, './'),
  },
};
