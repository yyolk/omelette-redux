# module.exports = (app) ->
#   # Your code
#
#
# Or if you want this to be a class
#
# module.exports = (app) ->
#   class app.MyCustomClass
#
#     constructor: (args) ->
#       # Your code
#
# Usage: new app.MyCustomClass(args)

module.exports = (app) ->
  fs = require 'fs'
  path = require 'path'
  class app.Works
    constructor: (next) ->
      # @work_names /d []
      works_dir = path.join(app.get('works'))
      that = @
      fs.readdir(works_dir, (err, files)->
          if err 
            return 
          works = []
          files.forEach (e) ->
            pattern = /.*\.markdown$/
            if not pattern.test(e)
              console.log 'not a post %j', e
              # files.pop(e)
            else
              console.log 'is a post %j', e
              works.push(e)
          that.work_names = works.map (f) ->
            pattern = /\.markdown$/
            if pattern.test(f)
              return f.replace(/\.markdown$/, '')
            else
              return ''
          # console.log @work_names
          # that.set_names(work_names)
          next()
        )
   
    @get_names = (cb) ->
      return cb(@work_names)

    set_names: (names) ->
      @work_names = names