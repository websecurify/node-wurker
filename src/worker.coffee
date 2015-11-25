Wurker = require './wurker'

module.exports = class extends Wurker
    @context: 'worker'

    constructor: ->
        @context = self

        super
