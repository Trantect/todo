
# ### Module dependencies.
classes = require("classes")
domify = require("domify")
html = require("./template")
View = require("view")
$ = require("jquery")

# ### ItemView inherits from `View`.
class ItemView extends View

  # ### Initialize a new view for `item`.
  #  * **Item** item
  #  * **public**
  constructor: (item) ->
    el = domify(html)
    # [`View.View(obj,el)`](https://github.com/component/view/blob/master/index.js#L29)
    View.call this, item, el[0]
    @classes = classes(@el)
    item.on "change complete", @toggleCompleteClass.bind(this)
    $(@el).children(".title").html(item.title())
    @bind "click .x", "remove"
    @bind "change [name=complete]", "changed"
    @toggleCompleteClass()
   
  # ### Complete state change.
  changed: (e) ->
    @obj.complete e.target.checked
    # [`save()`](https://github.com/component/model/blob/master/lib/proto.js#L155)
    @obj.save()

  # ### Remove the item.
  remove: ->
    @el.parentNode.removeChild @el
    # [`remove()`](https://github.com/component/model/blob/master/lib/proto.js#L127)
    @obj.remove()

  # ### Toggle root ".complete" class.
  toggleCompleteClass: ->
    if @obj.complete()
      $(@el).children("input").attr('checked','checked')
      @classes.add "complete"
    else
      $(@el).children("input").removeAttr('checked')
      @classes.remove "complete"

# Expose `ItemView`.
module.exports = ItemView
