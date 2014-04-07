module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")
    concurrent:
      dev:
        tasks: [
          "nodemon"
          "watch"
        ]
        options:
          logConcurrentOutput: true

    nodemon:
      dev:
        script: ["server.js"]
        options:
          ext: "js,coffee"
          env:
            PORT: 3000
          ignore: ['app/assets/**', 'public/**']

          callback: (nodemon) ->
            nodemon.on "restart", ->
              
              # Delay before server listens on port
              setTimeout ->
                require("fs").writeFileSync ".rebooted", "rebooted"
              , 1000

            nodemon.on "log", (event) ->
              console.log event.colour

    watch:
      server:
        files: [".rebooted"]
        options:
          livereload: true

      css:
        files: "**/*.styl"
        options:
          livereload: true

      templates:
        files: "**/*.jade"
        options:
          livereload: true

      js:
        files: "app/assets/js/*.coffee"
        options:
          livereload: true

  grunt.loadNpmTasks "grunt-nodemon"
  grunt.loadNpmTasks "grunt-concurrent"
  grunt.loadNpmTasks "grunt-contrib-watch"
  
  # grunt.registerTask('test', ['jshint', 'qunit']);
  grunt.registerTask "default", ["concurrent"]
  return
