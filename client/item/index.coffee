# ### Module dependencies.

# [`component/model`](https://github.com/component/model/blob/master/lib/index.js#L24)
model = require("model")
timestamps = require("model-timestamps")

# Item model.
# 
#  * [`attr(fn)`](https://github.com/component/model/blob/master/lib/static.js#L64)
#  * [`use(fn)`](https://github.com/component/model/blob/master/lib/static.js#L50)
#
#     model.base = '/' + name.toLowerCase();
module.exports = model("Item").attr("id").attr("title").attr("complete").use(timestamps)
