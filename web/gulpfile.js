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

gulp.task("typescript", function () {
    return browserify({
        basedir: '.',
        debug: true,
        entries: ['app/tsapp.ts','app/my-app.ts','public/lib/riot-ts/riot-ts.d.ts'],
        cache: {},
        packageCache: {}
    })
    .plugin(tsify)
    .bundle()
    .on('error', function (error) { console.error(error.toString()); })
    .pipe(source('bundle.js'))
    .pipe(gulp.dest("public/app"));
});

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
gulp.task('htmlpage', function() {
  var htmlSrc = './app/*.html',
      htmlDst = './public/app/';

  gulp.src(htmlSrc)
    .pipe(changed(htmlDst))
    .pipe(minifyHTML())
    .pipe(gulp.dest(htmlDst));
});

gulp.task('riotts', function() {
    	return gulp.src('./app/typescript/*.html')
    		.pipe(riotts( {indexByTagName: true, modular: true }))
    		            .pipe(gulp.dest('./public/app/tags'));

    });

gulp.task('bundle:app', function () {
  browserify({ entries: ['app/bootstrap.js'] })

    .transform(riotify, {  type: 'babel' }) // pass options if you need
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

gulp.task('browser-sync', function() {
    browserSync.init({
        server: {
            baseDir: "./public"
        }
    });
});
