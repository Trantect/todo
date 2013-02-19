Overview
--------

This Todo project is a sample Web project of following tools:

* Node.js
* Express
* CoffeeScript
* Jade
* Less
* Component
* docco-husky
* Uglify-js

The code is simple, but workable. It can be used as a reference or a template of a Web project.

Installation
------------

Get the source code with `git` or by downloading the source.

Install global npm packages:

	sudo npm install -g less jade coffee-script docco-husky component uglify-js

Install the required `node.js` packages:

    npm install
	
Build the project:

    make
	
Run it:

    node app
	
And generated docs are available at the `docs` folder.

Implementation
--------------

  In this implementation all private client-side components are located in `./client`,
  while server related REST end-points are in `./server`. The `views/index.jade`
  file bootstraps the client-side, and `app.coffee` is a small Express server
  to power the backend.

  Each client-side component in `./client` defines its own dependencies,
  both "local" (in the `./client` dir), and remote from public components
  that devs have created. On `make` these are installed and the builder
  outputs `./build`. The tiny 1-line middleware in `./server/build` executes
  `make` on-demand each time `index.html` is requested, so you don't even
  have to know about the build.
  
  `./Makefile` does quite some magics. It builds `.html` files (with `.jade` files),
  `.css` files (with `.less` files), `.js` files (with `.coffee` files and even the
  generated `.html` files), and finally packages `.js` files and `.css` files into 
  `./build/build.js` and `./build/build.css`.

  This is just _one_ example of how you could structure an application. You could
  for example take a more traditional approach with `./models`, `./controllers`,
  and `./views` etc. The entire app could be a single component, with all dependencies
  specified in the root ./component.json, however I recommend splitting your app
  into multiple as shown here, regardless of directory structure.

License
-------

  MIT
