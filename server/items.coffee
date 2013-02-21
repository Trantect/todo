# ### Faux db.

items = []

# ### Index of `id` in db.
indexOf = (id) ->
  i = 0
  len = items.length

  while i < len
    return i if id == items[i].id
    ++i

# ### GET all items.
exports.all = (req, res) ->
  res.send items

# ### POST a new item.
exports.create = (req, res) ->
  item = req.body
  id = items.push(item) - 1
  item.id = id
  res.send id: id

# ### DELETE item :id.
exports.remove = (req, res) ->
  id = req.params.id
  i = indexOf(id)
  items.splice i, 1
  res.send 200

# ### PUT changes to item :id.
exports.update = (req, res) ->
  id = parseInt req.params.id, 10
  i = indexOf(id)
  body = req.body
  item = items[i]
  return res.send(404, "item does not exist")  unless item
  item.title = body.title
  item.complete = body.complete
  res.send 200
