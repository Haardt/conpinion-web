'use strict';


const webpack = require('webpack');
const path = require('path')
const HtmlWebpackPlugin = require('html-webpack-plugin');
const ExtractTextPlugin = require("extract-text-webpack-plugin");

module.exports = {
  entry: './app/my-app.tag',
  output: {
    path: `${__dirname}/public/app`,
    filename: 'my-app.js'
  },
  module: {
    rules: [
    {
      test: /\.tag$/,
      exclude: /node_modules/,
      loader: 'riot-tag-loader',
      query: {
        type: 'es6', // transpile the riot tags using babel
        hot: true,
        debug: true
      }
    },
    {
      test: /\.js$/,
      exclude: /node_modules/,
      loader: 'babel-loader'
    },
    { test: /\.html$/, loader: 'html-loader' },
//    { test: /\.css$/,  loaders: ['style-loader', 'css-loader']},
    {
      test: /\.css$/,
      loader: ExtractTextPlugin.extract({
        fallback: "style-loader",
        use: "css-loader"
      })
    }
    ]
  },
  devServer: {
      contentBase: path.resolve(__dirname, './src'),  // New
  },
  plugins: [
    new ExtractTextPlugin("styles.css"),
    new HtmlWebpackPlugin({
                              title: 'my-app',
                              template: './app/my-app.ejs', // Load a custom template (ejs by default see the FAQ for details)
                            })
//    new webpack.ProvidePlugin({riot: 'riot'})
  ]
};

