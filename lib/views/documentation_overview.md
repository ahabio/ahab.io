## Problem

### Application Developers

Web application developers do not have a standard way to depend upon front-end
assets. Those developing Rails applications prefer the assets be bundled up in
Ruby gems, e.g.
[bootstrap-sass-rails](https://rubygems.org/gems/bootstrap-sass-rails). Those
developing Node.js applications prefer the assets be bundled up as npm modules,
e.g. [bootstrap-sass](https://npmjs.org/package/bootstrap-sass). Still others
prefer consuming Bower packages, e.g.
[bower-bootstrap-less](https://github.com/jozefizso/bower-bootstrap-less).
Maven developers have the own packaging system, and so naturally,
[Bootstrap-Maven](https://github.com/efsavage/Bootstrap-Maven) exists. Others
give up on dependency management of assets altogether and simply copy-and-paste
assets into their vendor directory.

### Library Authors

Library authors face a similar struggle. With so many competing packaging
systems -- at least one for every language commonly used for web development --
it’s hard to publish libraries for easy consumption. A few brave souls have
tried adding Bower or npm support to their libraries themselves, but the norm
is to simply produce a single distribution file and expect other developers to
create packaged versions for each idiosyncratic packaging system.

## Solution

### Lingua Franca

Where do Rails applications, Node.js, jQuery, Ember, Handlebars, and
Twitter-Bootstrap all meet? At the HTTP layer. (Also, to a degree, at the HTML
layer; let’s put that aside for now.)

Asset projects like jQuery, Ember, and Twitter-Bootstrap all publish their
assets to a CDN. Some of them also make the projects available as Rubygems, npm
modules, or bower components, but HTTP GETs are the one constant.

The URL is already the fundamental unit of reuse for front-end assets. `ahab`
rests firmly on this foundation, and hews as closely as possible to HTTP
principles for more advanced features.

### Learn More

Learn more about the [protocol](/documentation/protocol).
