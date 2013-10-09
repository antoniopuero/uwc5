module.exports =
    compile:
        options:
            import: ['nib']
            compress: true
        files:
            'public/css/main.css': ['public/stylus/*.styl']
