module.exports = {
  themeCss: (theme, css) ->
    variables = theme.variables
    css = css.replace(/(\S+)\s*\/\*\{([a-z_-]+)\}\*\//g, (match, value, varName) ->
      newValue = theme.variables[varName]
      value = newValue if newValue?
      return "#{value} /*{#{varName}}*/"
    )
    return css
}