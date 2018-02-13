assert = require "assert"
render = require "../"
fs     = require "fs"
path   = require "path"

expected = """
CACHE MANIFEST

a
b
c
bar
buzz

NETWORK:
*
*/*

FALLBACK:
foo bar
fizz buzz
"""


describe "renderAppcacheManifest", ->
  it "renders an appcache manifest", ->
    assert.equal expected, render
      cache: ["a","b","c","bar","buzz"]
      network: ["*","*/*"]
      fallback:
        foo: "bar"
        fizz: "buzz"

  it "renders an appcache manifest from tokens", ->
    manifestPath = path.resolve(__dirname, "../fixtures/html5-doctor.appcache")
    expect = fs.readFileSync manifestPath, 'utf8'
    tokens = require "../fixtures/html5-doctor-tokens.json"
    assert.equal expect, render(tokens)
  
  it "renders a unique appcache manfiest", ->
    actual = render
      cache: ["a","b","c","bar","buzz"]
      network: ["*","*/*"]
      unique: yes
    assert ~actual.indexOf("# Math.random() == ")