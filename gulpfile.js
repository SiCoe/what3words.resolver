var gulp = require('gulp');
var ts = require('gulp-typescript');
 
var tsProject = ts.createProject("tsconfig.json");

gulp.task('default', ['build']);
gulp.task('build', ['typescriptTranspalation']);

gulp.task('typescriptTranspalation', function() {
    var tsResult = tsProject.src()
        .pipe(ts(tsProject));

    return tsResult.js.pipe(gulp.dest("what3words-resolver"));
});
 
gulp.task('watch', ['typescriptTranspalation'], function() {
    gulp.watch('what3words-resolver/typescript/**/*.ts', ['typescriptTranspalation']);
});