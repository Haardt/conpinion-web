var gulp = require('gulp')
var browserify = require('browserify')
var watchify = require('watchify')
var riotify = require('riotify')
var babelify = require('babelify')
var source = require('vinyl-source-stream')
var buffer = require('vinyl-buffer')
var minifyHTML = require('gulp-minify-html');
var changed = require('gulp-changed');
//var watch = require('gulp-watch');
var browserSync = require('browser-sync');
var riotts = require('gulp-riotts');
var ts = require('gulp-typescript');
var concat = require('gulp-concat');
var sourcemaps = require('gulp-sourcemaps');
var tsify = require("tsify");
var gutil = require("gulp-util");
var merge = require("gulp-stream");
var merge2 = require("merge2");
var print = require("gulp-print");

gulp.task("copy-html", function () {
    return gulp.src("app/**/*.html")
            .pipe(gulp.dest("public/app"));
});

gulp.task('riotts', function () {
    return precompiledHtmlTags;
});

var watchedBrowserify = browserify({
    basedir: 'app',
    debug: true,
    entries: ['my-app.ts'],
    cache: {},
    packageCache: {}
}).plugin(tsify);

var precompiledHtmlTags = gulp.src('./app/view/*.html')
//        .pipe(changed('./app/view/*.html'))
//        .pipe(minifyHTML())
        .pipe(riotts({indexByTagName: true, modular: false, compact: true}))
        // .pipe(concat('preCompHmtl.js'))
        .pipe(print());
//        .pipe(gulp.dest('./app/generated/'));


//watchedBrowserify.on('log', gutil.log);

gulp.task('bundle', ['copy-html'], function ()
{
    return merge2(watchedBrowserify
            .bundle()
            .on('error', function (error) {
                console.error(error.toString());
            }).pipe(source('bundle.js'))
            .pipe(buffer()),
            gulp.src('./app/view/*.html')
//        .pipe(changed('./app/view/*.html'))
//        .pipe(minifyHTML())
            .pipe(riotts({indexByTagName: true, modular: false, compact: true})))
            .pipe(print())
            .pipe(concat('bundle-all.js'))
            .pipe(gulp.dest("public/app"));

});

gulp.task('watch', ['bundle'], function ()
{
    var watcher = gulp.watch('./app/**/*', ['refresh']);
    watcher.on('change', function (event)
    {
        console.log('File ' + event.path + ' was ' + event.type + ', running tasks...');
    });
});

/**
 * This task starts browserSync. Allowing refreshes to be called from the gulp
 * bundle task.
 */
gulp.task('browser-sync', ['bundle', 'watch'], function ()
{
    return browserSync({server: {baseDir: './public'}});
});

/**
 * This is the default task which chains the rest.
 */
gulp.task('default', ['browser-sync']);

/**
 * Using a dependency ensures that the bundle task is finished before reloading.
 */
gulp.task('refresh', ['bundle'], browserSync.reload);








// old
gulp.task('typescript2', function () {

    var tsResult = gulp.src(['app/**/*.ts', 'public/lib/riot-ts/riot-ts.d.ts'])
            .pipe(sourcemaps.init())
            .pipe(ts({
                sortOutput: true,
                typescript: require('typescript'),
                module: 'commonjs',
                "experimentalDecorators": true
            }));
    return tsResult.js.pipe(concat('app.js'))
            .pipe(sourcemaps.write())
            .pipe(gulp.dest('./public/app/'));
});

// minify new or changed HTML pages
gulp.task('htmlpage', function () {
    var htmlSrc = './app/*.html',
            htmlDst = './public/app/';

    gulp.src(htmlSrc)
            .pipe(changed(htmlDst))
            .pipe(minifyHTML())
            .pipe(gulp.dest(htmlDst));
});

gulp.task('bundle:app', function () {
    browserify({entries: ['app/bootstrap.js']})

            .transform(riotify, {type: 'babel'}) // pass options if you need
            .transform(babelify)
            .bundle()
            .pipe(source('bundle.js'))
            .pipe(gulp.dest('./public/app/'));

    /*
     var b = browserify(watchify.args)
     //      b.external(VENDORS)
     //      b.add(APP_ENTRY)
     b.transform(babelify)
     b.transform(riotify)
     b.bundle()
     .pipe(source('bundle.js'))
     .pipe(buffer())
     .pipe(gulp.dest('./public/app/'))
     
     return b
     */
})

gulp.task('browser-sync-old', function () {
    browserSync.init({
        server: {
            baseDir: "./public"
        }
    });
});
