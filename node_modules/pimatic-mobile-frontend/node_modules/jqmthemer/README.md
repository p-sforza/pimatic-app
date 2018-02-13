jqmthemer
===========

Theme a jQuery Mobile theme css file, by replacing css values by its variable names.

Usage
-----

Create a theme file:

```coffee
theme = {
  'name': 'classic'
  'css': [
    "app/css/themes/default/jquery.mobile.inline-svg-1.4.2.css",
    "app/css/themes/default/jquery.mobile.structure-1.4.2.css" 
  ],
  'extraCss': [
    'themes/jqm/classic.css'
  ]
}
theme.variables = {
  'a-bar-background-color': '#e9e9e9'
}
module.exports = theme
```

and apply it:

```coffee
jqmthemer = require 'jqmthemer'

theme = require(themeFile)
css = fs.readFileSync(cssfile)
themedCss = jqmthemer.themeCss(theme, css)
```

You can find some example theme files [here](https://github.com/pimatic/pimatic-mobile-frontend/tree/master/themes).

