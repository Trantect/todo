sh = require("sh")

module.exports = (grunt) ->
  # Project configuration.
  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")
    uglify:
      build:
        src: "build/build.js"
        dest: "build/build.min.js"
    cssmin:
      compress:
        files:
          "build/build.min.css": ["build/build.css"]
    watch:
      files: ["build/build.js", "build/build.css"]
      tasks: ["uglify", "cssmin"]
    less:
      development:
        files:
          "client/boot/style.css": "client/boot/style.less"
          "client/item-view/style.css": "client/item-view/style.less"
      production:
        files:
          "client/boot/style.css": "client/boot/style.less"
          "client/item-view/style.css": "client/item-view/style.less"
    jade:
      development:
        files:
          "client/item-view/template.html": "client/item-view/template.jade"
  
  # Load the plugin that provides the "uglify" task.
  grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks 'grunt-contrib-cssmin'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks "grunt-contrib-watch"
  
  # Default task(s).
  grunt.registerTask "component_convert", "Convert template HTML to JS", ->
    done = @async()
    sh("component convert client/item-view/template.html").and ->
      done()
  grunt.registerTask 'component_install', 'Install components', ->
    done = @async()
    sh("component install").and ->
      done()
  grunt.registerTask 'component_build', 'Build package', ->
    done = @async()
    sh('component build').and ->
      done()
  grunt.registerTask 'docs', 'Build docs', ->
    done = @async()
    sh('docco-husky README.md Gruntfile.coffee client/item-view/index.coffee client/item/index.coffee client/boot/index.coffee').and ->
      done()
  grunt.registerTask "default", [
    "jade", "less", "component_convert", 'component_build',
    "cssmin", "uglify", "docs"
    ]
