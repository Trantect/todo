
/**
 * Module dependencies.
 */

var Item = require('item')
  , ItemView = require('item-view')
  , Collection = require('collection')
  , keyname = require('keyname')
  , page = require('page')

/**
 * Collection of todo Items.
 */

var items = new Collection;

/**
 * Todo input.
 */

var input = document.querySelector('[name=todo]');

/**
 * Todo list.
 */

var list = document.querySelector('#todos');

/**
 * Handle keydown.
 */

input.onkeydown = function(e){
  switch (keyname(e.which)) {
    case 'enter':
      // input
      var str = e.target.value;
      if ('' == str.trim()) return;
      e.target.value = '';

      // item
      var item = new Item({ title: str });
      items.push(item);
      item.save();

      // view
      var view = new ItemView(item);
      list.appendChild(view.el);
      break;
  }
};

/**
 * Clear list.
 */

page('*', function(ctx, next){
  list.innerHTML = '';
  next();
});

/**
 * All items.
 */

page('/', function(){
  Item.all(function(err, items){
    items.each(function(item){
      var view = new ItemView(item);
      list.appendChild(view.el);
    });
  });
});

/**
 * Completed items.
 */

page('/complete', function(){
  Item.all(function(err, items){
    items.select('complete()').each(function(item){
      var view = new ItemView(item);
      list.appendChild(view.el);
    });
  });
});

/**
 * Incomplete items.
 */

page('/incomplete', function(){
  Item.all(function(err, items){
    items.reject('complete()').each(function(item){
      var view = new ItemView(item);
      list.appendChild(view.el);
    });
  });
});

page();

var Pager = require('pager');
var pager = new Pager;
pager.el.appendTo('#pager');
pager.total(50).perpage(10).render();
pager.on('show', function(n){
  console.log('selected page %d', n);
});

var Progress = require('progress');

var progress = new Progress;
document.querySelector('#progress').appendChild(progress.el);

var n = 0;
var id = setInterval(function(){
  if (n == 100) clearInterval(id);
  progress.update(n++);
}, 50);