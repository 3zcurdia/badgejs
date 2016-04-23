module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')
    coffee:
      app:
        expand: true
        cwd: 'src'
        src: ['**/*.coffee']
        dest: 'src'
        ext: '.js'
    sass:
      dist:
        files: [
          expand: true
          cwd: 'src'
          src: ['*.scss']
          dest: 'src'
          ext: '.css'
        ]
    cssmin:
      target:
        files: [
          expand: true
          cwd: 'src'
          src: ['*.css', '!*.min.css']
          dest: 'build'
          ext: '.min.css'
        ]
    uglify:
      options: banner: '/*! <%= pkg.name %> v<%= pkg.version %> <%= grunt.template.today("yyyy-mm-dd") %> */\n'
      build:
        src: 'src/<%= pkg.name %>.js'
        dest: 'build/<%= pkg.name %>.min.js'

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-cssmin'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.registerTask 'default', ['sass', 'coffee', 'cssmin', 'uglify']
