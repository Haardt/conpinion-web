require('coffee-script/register');

module.exports = function (grunt) {

    var pkg = grunt.file.readJSON('bower.json');

    grunt.initConfig({
        pkg: pkg,

        copyrightSince: function (year) {
            now = new Date().getFullYear();
            return year + (now > year ? '-' + now : '');
        },

        clean: {
            build: ['build'],
            dist: ['node_modules', 'public/lib', 'public/app', 'public/index.html']
        },

        copy: {
            options: {
                processContent: function (content, srcpath) {
                    return grunt.template.process(content);
                }
            },
            license: {
                src: 'tmpl/license.tmpl',
                dest: 'LICENSE.txt'
            }
        },

        less: {
            dist: {
                files: grunt.file.expandMapping(['app/**/*.less'], 'public/app/', {
                    rename: function (dest, src) {
                        return dest + src.replace(/app\/(.+)\.less$/, '$1.css');
                    }
                })
            }
        },

        riot: {
            options: {
                template: 'pug',
                type: 'babel',
                concat: false
            },
            dist: {
                expand: true,
                src: ['app/**/*.pug'],
                dest: 'public',
                ext: '.js'
            }
        },

        htmlbuild: {
            dist: {
                cwd: 'app',
                src: ['**/*.html', '**/*.json', '**/*.js'],
                dest: 'public/app',
                expand: true,
                options: {
                    data: {
                        copyright: grunt.file.read('tmpl/copyright.tmpl')
                    }
                }
            }
        },

        selenium_standalone: {
            your_target: {
                seleniumVersion: '2.47.1',
                seleniumDownloadURL: 'http://selenium-release.storage.googleapis.com',
                drivers: {
                    chrome: {
                        version: '2.45',
                        arch: process.arch,
                        baseURL: 'http://chromedriver.storage.googleapis.com'
                    },
                    ie: {
                        version: '2.45',
                        arch: process.arch,
                        baseURL: 'http://selenium-release.storage.googleapis.com'
                    }
                }
            }
        },
        webdriver: {
            test: {
                configFile: './test/wdio.conf.js'
            }
        },

        connect: {
            server: {
                options: {
                    port: 8080,
                    base: 'public',
                    index: 'app/index.html'
                }
            },
            tests: {
                options: {
                    port: 8080,
                    base: ['public','test']
                }
            }
        },

        watch: {
            stylesheets_less: {
                files: ['app/**/*.less'],
                tasks: ['newer:less', 'newer:htmlbuild']
            },
            riot: {
                files: ['app/**/*.pug'],
                tasks: ['newer:riot']
            },
            html: {
                files: 'app/**/*.html',
                tasks: ['newer:htmlbuild']
            },
            js: {
                files: 'app/**/*.js',
                tasks: ['newer:jsbuild']
            },
            tests: {
                files: 'test/*.html',
                tasks: []
            }
        },

        bumpversion: {
            options: {
                files: ['bower.json'],
                updateConfigs: ['pkg'],
                commit: true,
                commitFiles: ['-a'],
                commitMessage: 'Bump version number to %VERSION%',
                createTag: true,
                tagName: '%VERSION%',
                tagMessage: 'Version %VERSION%',
                push: false
            }
        },

        changelog: {
            options: {
                version: pkg.version
            }
        },

        replace: {
            indexHtmlForTest: {
                src: 'app/index.html.tmpl',
                dest: './public/index.html',
                replacements: [{
                    from: /<grapp-app-globals-set key="(.+)ApiUrl" value=".+"><\/grapp-app-globals-set>/g,
                    to: '<grapp-app-globals-set key="$1ApiUrl" value="http://localhost:' +
                    '<%= process.env["GRUNT_CONNECT_PORT"] %>/api/$1"></grapp-app-globals-set>'
                }]
            }
        },

        shell: {
            cucumber: {
                command: 'node node_modules/cucumber/bin/cucumber.js \
                  -r features/step_definitions -r features/support \
                  -f pretty -t ~@ignore --coffee'
            },
            test: {
                command: 'xvfb-run -a ./bin/grunt all-test'
            },
        }
    });

    grunt.loadNpmTasks('grunt-bump');
    grunt.loadNpmTasks('grunt-coffeelint');
    grunt.loadNpmTasks('grunt-contrib-clean');
    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-contrib-connect');
    grunt.loadNpmTasks('grunt-contrib-copy');
    grunt.loadNpmTasks('grunt-contrib-less');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-conventional-changelog');
    grunt.loadNpmTasks('grunt-html-build');
    grunt.loadNpmTasks('grunt-newer');
    grunt.loadNpmTasks('grunt-shell');
    grunt.loadNpmTasks('grunt-text-replace');
    grunt.loadNpmTasks('grunt-riot');
    grunt.loadNpmTasks('grunt-selenium-standalone');
    grunt.loadNpmTasks('grunt-webdriver');

    grunt.registerTask('build', 'Compile all assets and create the distribution files',
        ['less', 'riot', 'htmlbuild']);

    grunt.registerTask('cucumber-test', 'Run the cucumber tests', function () {
        grunt.event.once('connect.tests.listening', function (host, port) {
            process.env['GRUNT_CONNECT_PORT'] = port;
            grunt.task.run('replace:indexHtmlForTest');
            grunt.task.run('shell:cucumber');
        });
        grunt.task.run('connect:tests');
    });

    grunt.registerTask('wct-test', function () {
        var
            done = this.async(),
            wct = require('web-component-tester'),
            options = {
                remote: false,
                persistent: false,
                root: 'public',
                plugins: {
                    local: {
                        browsers: ['chrome']
                    }
                }
            };
        wct.test(options, function (error) {
            done();
            if (error) {
                grunt.fail.warn(error);
            }
        });
    });

    grunt.registerTask('all-test', 'Test the web application', ['wct-test', 'cucumber-test']);

    grunt.registerTask('test', 'Test the web application', ['shell:test']);

    grunt.task.renameTask('bump', 'bumpversion');

    grunt.registerTask('bump', '', function (versionType) {
        versionType = versionType ? versionType : 'patch';
        grunt.task.run(['bumpversion:' + versionType + ':bump-only',
            'build', 'copy:license', 'changelog', 'bumpversion::commit-only']);
    });

    grunt.registerTask('default', 'Build the software and watch for changes',
        ['build', 'connect:server', 'watch']
    );
};
