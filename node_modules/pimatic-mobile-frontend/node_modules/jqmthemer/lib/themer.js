module.exports = {
  themeCss: function(theme, css) {
    var variables;
    variables = theme.variables;
    css = css.replace(/(\S+)\s*\/\*\{([a-z_-]+)\}\*\//g, function(match, value, varName) {
      var newValue;
      newValue = theme.variables[varName];
      if (newValue != null) {
        value = newValue;
      }
      return "" + value + " /*{" + varName + "}*/";
    });
    return css;
  }
};
