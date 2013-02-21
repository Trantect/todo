# ### Module dependencies.
exec = require("child_process").exec

# ###Build components.
# *public*
module.exports = (req, res, next) ->
  
  # you could use the js builder, but
  # this works just fine, though slower
  exec "make", next
