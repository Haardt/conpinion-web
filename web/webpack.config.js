'use strict';

let webpack = require('webpack');
var HtmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
  entry: './app/my-app.tag',
  output: {
    path: `${__dirname}/public/app`,
    filename: 'my-app.js'
  },
  module: {
    preLoaders: [
      { test: /\.tag$/, exclude: /node_modules/, loader: 'riotjs-loader', query: { module:'true', type: 'es6' } }
    ],
    loaders: [
      { test: /\.html$/, loader: 'html-loader' },
      { test: /\.css$/,  loaders: ['style', 'css']}
    ]
  },
  plugins: [
    new webpack.optimize.OccurenceOrderPlugin(),
    new HtmlWebpackPlugin({
                              title: 'my-app',
                              template: './app/my-app.ejs', // Load a custom template (ejs by default see the FAQ for details)
                            }),
    new webpack.ProvidePlugin({riot: 'riot'})
  ]
};

