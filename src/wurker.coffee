module.exports = class
    constructor: ->
        throw new Error 'invalid context' unless @context

        @exports = {}

        @context.addEventListener 'message', @handleInvoke.bind @

    invoke: (method, args..., callback) ->
        id = "invoke-#{Date.now()}-#{Math.random()}"

        @context.addEventListener 'message', handler = (event) =>
            return unless event.data.type is '_return'

            throw new Error 'undefined method' unless event.data.method
            throw new Error 'undefined args' unless event.data.args
            throw new Error 'undefined id' unless event.data.id

            return unless event.data.method is method
            return unless event.data.id is id

            @context.removeEventListener 'message', handler

            callback.apply @, event.data.args

        @context.postMessage {
            type: '_invoke'
            method: method
            args: args
            id: id
        }

    handleInvoke: (event) ->
        return unless event.data.type is '_invoke'

        throw new Error 'undefined method' unless event.data.method
        throw new Error 'undefined args' unless event.data.args
        throw new Error 'undefined id' unless event.data.id

        throw new Error "undefined method #{event.data.method}" unless event.data.method of @exports

        @exports[event.data.method].apply @exports, [].concat(event.data.args, [ (args...) =>
            @context.postMessage {
                type: '_return'
                method: event.data.method
                args: args
                id: event.data.id
            }
        ])
