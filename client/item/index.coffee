# ### Module dependencies.
model = require("model")
timestamps = require("model-timestamps")

# Item model.
module.exports = model("Item").attr("id").attr("title").attr("complete").use(timestamps)
