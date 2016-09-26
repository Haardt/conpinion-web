var gulp = require('gulp')
var browserify = require('browserify')
var watchify = require('watchify')
var babelify = require('babelify')
var source = require('vinyl-source-stream')
var transform = require('vinyl-transform');
var buffer = require('vinyl-buffer')
var minifyHTML = require('gulp-minify-html');
var changed = require('gulp-changed');
//var watch = require('gulp-watch');
var browserSync = require('browser-sync');
var ts = require('gulp-typescript');
var concat = require('gulp-concat');
var sourcemaps = require('gulp-sourcemaps');
var gutil = require("gulp-util");
var merge = require("gulp-stream");
var merge2 = require("merge2");
var print = require("gulp-print");
var riot = require("gulp-riot");
var chalk = require('chalk')
var rename = require('gulp-rename')
var uglify = require('gulp-uglify')
var Server = require('karma').Server;

// Configuration

var sourceSet = {
    src: './app',
    app: './public/app/my-app.js',
    css: './public/app/app.css',
    tags: './app/**/*.tag'
}

var destSet = {
    dest: './public/app',
    bundleJs: 'bundle.js',
    bundleCss: 'bundle.css',
    dist: './dist'
}

// Functions

function tags() {
    return gulp.src(sourceSet.tags)
            .pipe(changed(destSet.dest, {extension: '.js'}))
            .pipe(print())
            .pipe(riot(
                    {
                        type: 'typescript',
                        modular: true
                    }));
}

function map_error(err) {
    if (err.fileName) {
        // regular error
        gutil.log(chalk.red(err.name)
                + ': '
                + chalk.yellow(err.fileName.replace(__dirname + sourceSet.src, ''))
                + ': '
                + 'Line '
                + chalk.magenta(err.lineNumber)
                + ' & '
                + 'Column '
                + chalk.magenta(err.columnNumber || err.column)
                + ': '
                + chalk.blue(err.description))
    } else {
        // browserify error..
        gutil.log(chalk.red(err.name)
                + ': '
                + chalk.yellow(err.message))
    }

    this.emit('end');
}

function bundle(bundler, destName, dest) {
    return bundler.bundle()
            .on('error', map_error)
            .pipe(source(destName))
            .pipe(buffer())
            .pipe(gulp.dest(dest))
            .pipe(rename(destName));
}

// Tasks

// Without watchify
gulp.task('bundle:js', function () {
    var bundler = browserify(sourceSet.app, {debug: true})
    return bundle(bundler, destSet.bundleJs, destSet.dest)
            .pipe(sourcemaps.init({loadMaps: true}))
            // capture sourcemaps from transforms
            //.pipe(uglify())
            .pipe(sourcemaps.write('.'))
            .pipe(gulp.dest(destSet.dest));
});

// Without sourcemaps
gulp.task('bundle:production', function () {
    var bundler = browserify(sourceSet.app)

    return bundler.bundle()
            .on('error', map_error)
            .pipe(source(sourceSet.app))
            .pipe(buffer())
            .pipe(rename('app.min.js'))
            .pipe(uglify())
            .pipe(gulp.dest(destSet.dist))
});

gulp.task("copy-html", function () {
    return gulp.src(["./app/**/*.html", "./app/**/*.js", "./app/**/*.css"])
            .pipe(gulp.dest(destSet.dest));
});

gulp.task('bundle:css', function () {
    var bundler = browserify(sourceSet.css, {debug: true})
    bundler.transform('browserify-css', {autoInject: true});
    return bundle(bundler, destSet.bundleCss, destSet.dest)
            .pipe(gulp.dest(destSet.dest));
})

gulp.task("riot", function () {
    return tags().pipe(gulp.dest(destSet.dest));
});

gulp.task('watchify', function () {
    var args = merge(watchify.args, {debug: true})
    var bundler = watchify(browserify(sourceSet.app, args))
    bundle(bundler, sourceSet.app, destSet.bundleJs)
    .pipe(sourcemaps.init({loadMaps: true}))
            // capture sourcemaps from transforms
            //.pipe(uglify())
            .pipe(sourcemaps.write('.'))
            .pipe(gulp.dest(dest));

    bundler.on('update', function () {
        bundle_js(bundler)
    })
})

gulp.task('bundle:dev', ['riot', 'copy-html', 'bundle:css', 'bundle:js']);
gulp.task('bundle:dist', ['riot', 'browserify-production']);

gulp.task('watch', function ()
{
    var watcher = gulp.watch('./app/**/*', ['refresh']);
    watcher.on('change', function (event)
    {
        console.log('File ' + event.path + ' was ' + event.type + ', running tasks...');
    });
});

/**
 * Using a dependency ensures that the bundle task is finished before reloading.
 */
gulp.task('refresh', ['bundle:dev', ], browserSync.reload);


/**
 * This task starts browserSync. Allowing refreshes to be called from the gulp
 * bundle task.
 */
gulp.task('browser-sync', ['bundle:dev', 'watch'], function ()
{
    return browserSync({server: {
            baseDir: './public/app',
            index: 'index.html'}});
});

/**
 * This is the default task which chains the rest.
 */
gulp.task('default', ['browser-sync']);

/**
 * Run test once and exit
 */
gulp.task('test', function (done) {
  new Server({
    configFile: __dirname + '/karma.conf.js',
    singleRun: true
  }, done).start();
});

