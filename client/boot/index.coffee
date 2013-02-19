# ### Module dependencies.
Item = require("item")
ItemView = require("item-view")
Collection = require("collection")
keyname = require("keyname")
page = require("page")

# Collection of todo Items.
items = new Collection

# Todo input.
input = document.querySelector("[name=todo]")

# Todo list.
list = document.querySelector("#todos")

# ### Handle keydown.
input.onkeydown = (e) ->
  switch keyname(e.which)
    when "enter"
      
      # input
      str = e.target.value
      return  if "" is str.trim()
      e.target.value = ""
      
      # item
      item = new Item(title: str)
      items.push item
      item.save()
      
      # view
      view = new ItemView(item)
      list.appendChild view.el

# ### Clear list.
page "*", (ctx, next) ->
  list.innerHTML = ""
  next()


# ### All items.
page "/", ->
  Item.all (err, items) ->
    items.each (item) ->
      view = new ItemView(item)
      list.appendChild view.el

# ### Completed items.
page "/complete", ->
  Item.all (err, items) ->
    items.select("complete()").each (item) ->
      view = new ItemView(item)
      list.appendChild view.el

# ### Incomplete items.
page "/incomplete", ->
  Item.all (err, items) ->
    items.reject("complete()").each (item) ->
      view = new ItemView(item)
      list.appendChild view.el

page()

# Append a paginator
Pager = require("pager")
pager = new Pager
pager.el.appendTo "#pager"
pager.total(50).perpage(10).render()
pager.on "show", (n) ->
  console.log "selected page %d", n

# Append a progress pie
Progress = require("progress")
progress = new Progress
document.querySelector("#progress").appendChild progress.el
n = 0
id = setInterval(->
  clearInterval id  if n is 100
  progress.update n++
, 50)
