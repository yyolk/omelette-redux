module.exports = (app) ->
  class app.ApplicationController

    # GET /
    @index = (req, res) ->
      Works = new app.Works(()->
      # Works.get_names((work_names)->
      #   console.log 'at index, worknames:', work_names      
      # )
        console.log Works.work_names
        res.render 'index',
          view: 'index'
          works: Works.work_names
      )