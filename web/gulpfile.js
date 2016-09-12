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

// minify new or changed HTML pages
gulp.task('htmlpage', function() {
  var htmlSrc = './app/*.html',
      htmlDst = './public/app/';

  gulp.src(htmlSrc)
    .pipe(changed(htmlDst))
    .pipe(minifyHTML())
    .pipe(gulp.dest(htmlDst));
});


gulp.task('bundle:app', function () {
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
})

gulp.task('browser-sync', function() {
    browserSync.init({
        server: {
            baseDir: "./public"
        }
    });
});
