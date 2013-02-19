
# ### Module dependencies.
classes = require("classes")
domify = require("domify")
html = require("./template")
View = require("view")

# ### ItemView inherits from `View`.
class ItemView extends View

  # ### Initialize a new view for `item`.
  #  * **Item** item
  #  * **public**
  constructor: (item) ->
    el = domify(html)
    View.call this, item, el[0]
    @classes = classes(@el)
    item.on "change complete", @toggleCompleteClass.bind(this)
    @el.querySelector(".title").innerHTML = item.title()
    @bind "click .x", "remove"
    @bind "change [name=complete]", "changed"
    @toggleCompleteClass()
   
  # ### Complete state change.
  changed: (e) ->
    @obj.complete e.target.checked
    @obj.save()

  # ### Remove the item.
  remove: ->
    @el.parentNode.removeChild @el
    @obj.remove()

  # ### Toggle root ".complete" class.
  toggleCompleteClass: ->
    if @obj.complete()
      @classes.add "complete"
    else
      @classes.remove "complete"

# Expose `ItemView`.
module.exports = ItemView