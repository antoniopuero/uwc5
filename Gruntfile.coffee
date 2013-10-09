module.exports = (grunt) ->

    grunt.initConfig
        pkg: grunt.file.readJSON("./package.json")

        stylus: require "./grunt/configs/stylus.coffee"

        watch:
            css:
                files: ['public/**/*.styl'],
                tasks: ['stylus']

        cssmin:
            combine:
                options:
                    keepSpecialComments: 0
                files:
                    'public/css/app.min.css' : ['public/css/*.css']

    grunt.loadNpmTasks 'grunt-contrib-stylus'
    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-contrib-cssmin'

    grunt.registerTask "nodemon", "Run nodemon", ()->
        grunt.util.spawn cmd: "nodemon", args: ["app.coffee"], opts: {stdio: 'inherit'}

    grunt.registerTask 'prod', 'Prepare for production', () ->
        grunt.task.run ['stylus', 'cssmin']

    grunt.registerTask 'default', 'Run application', () ->
        grunt.task.run ["nodemon", 'stylus', 'watch']
