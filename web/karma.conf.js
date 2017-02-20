// Karma configuration
// Generated on Sat Oct 01 2016 00:11:28 GMT+0200 (CEST)
var webpackConfig = require('./webpack.config.js');
//webpackConfig.entry = {};

module.exports = function (config) {
    config.set({

        // base path that will be used to resolve all patterns (eg. files, exclude)
        basePath: './',

        // frameworks to use
        // available frameworks: https://npmjs.org/browse/keyword/karma-adapter
        frameworks: ['jasmine', 'mocha', 'chai'],
        plugins: [
            'karma-phantomjs-launcher',
            'karma-jasmine',
            'karma-mocha',
            'karma-chai',
            'karma-mocha-reporter',
            'karma-webpack',
            'karma-babel-preprocessor',
            'karma-chrome-launcher'
         //   'babel-plugin-transform-es2015-modules-umd'
        ],
        // list of files / patterns to load in the browser
        files: [
            {
                pattern: 'app/**/*.html',
                watched: true,
                served: true,
                included: false
            },
            './app/**/*.js'
        ],

        // list of files to exclude
        exclude: [
        ],

        preprocessors: {
            // add webpack as preprocessor
            'app/*-test.js': ['webpack'],
            'app/**/*.js': ['webpack']
          },
        babelPreprocessor: {
            options: {

              //  "plugins": ["transform-es2015-modules-umd"]
            }
        },
          webpack: webpackConfig,

          webpackMiddleware: {
            // webpack-dev-middleware configuration
            // i. e.
            stats: 'errors-only'
          },

        // test results reporter to use
        // possible values: 'dots', 'progress'
        // available reporters: https://npmjs.org/browse/keyword/karma-reporter
        reporters: ['mocha'],

        // web server port
        port: 9876,

        // enable / disable colors in the output (reporters and logs)
        colors: true,

        // level of logging
        // possible values: config.LOG_DISABLE || config.LOG_ERROR || config.LOG_WARN || config.LOG_INFO || config.LOG_DEBUG
        logLevel: config.LOG_INFO,

        // enable / disable watching file and executing tests whenever any file changes
        autoWatch: false,

        // start these browsers
        // available browser launchers: https://npmjs.org/browse/keyword/karma-launcher
        browsers: ['Chrome_without_security'], //['PhantomJS'] ,
        customLaunchers: {
              Chrome_without_security: {
                base: 'Chrome',
                flags: ['--disable-web-security']
              }
           },
        // Continuous Integration mode
        // if true, Karma captures browsers, runs the tests and exits
        singleRun: true,

        // Concurrency level
        // how many browser should be started simultaneous
        concurrency: Infinity
    })
}
