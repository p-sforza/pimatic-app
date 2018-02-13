module.exports = (data) ->
  return fromTokens data if Array.isArray data
  return fromTokens data if Array.isArray data.tokens
  return fromObject data

fromObject = (data) ->
  data.cache = [] unless data.cache
  data.network = [] unless data.network
  data.fallback = {} unless data.fallback
  data.comments = [] unless data.comments
  data.comments.push data.comment if data.comment
  hasComments = data.comments.length > 0 or data.lastModified or data.unique
  lines = []
  lines.push "CACHE MANIFEST"
  lines.push ""
  lines.push entry for entry in data.cache
  if data.network.length > 0
    lines.push ""
    lines.push "NETWORK:"
    lines.push entry for entry in data.network
  if Object.keys(data.fallback).length > 0
    lines.push ""
    lines.push "FALLBACK:"
    lines.push "#{pattern} #{fallback}" for pattern, fallback of data.fallback
  lines.push "" if data.timestamp or data.unique
  lines.push "# #{comment}" for comment in data.comments
  lines.push "# Last modified at #{data.lastModified.toUTCString()}." if data.lastModified
  lines.push "# Math.random() == #{Math.random()}" if data.unique
  lines.join "\n"

# generate an appcache manifest by traversing a list of tokens
fromTokens = (tokens) ->
  # TODO: group modes together in the output
  out = ''
  for t in tokens
    line = null
    if t.type is 'magic signature'
      line = t.value
    else if t.type is 'newline'
      out += '\n'
    else if t.type is 'comment'
      line = '# ' + t.value.trim() 
    else if t.type is 'mode' and t.value isnt 'unknown'
      line = t.value + ':'
    else if t.type is 'data'
      line = t.tokens.join ' '
    if line
      out = out + line + '\n'
  out
