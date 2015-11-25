Wurker = require './wurker'

module.exports = class extends Wurker
    @context: 'window'

    constructor: (uri) ->
        @context = new window.Worker uri

        super

    postMessage: (message) ->
        @context.postMessage message

    addEventListener: (event, handler) ->
        @context.addEventListener event, handler

    removeEventListener: (event, handler) ->
        @context.removeEventListener event, handler
