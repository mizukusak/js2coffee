require './setup'

describe 'Precedence', ->
  {getPrecedence} = require '../lib/helpers'

  test = (js, level) ->
    it "[#{level}] #{js}", ->
      node = require('esprima').parse(js).body[0].expression
      result = getPrecedence(node)
      if result isnt level
        console.log node
      expect(result).eq(level)

  test 'a * 2', 3
  test 'a instanceof b', 6
  test 'a && b', 11
  test 'a || b', 12
  test 'void 0', 2
  test 'a.b', 1
  test 'a', 0
  test '2', 0