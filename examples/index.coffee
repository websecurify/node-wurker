Wurker = require 'wurker'

switch Wurker.context
    when 'window'
        v = new Wurker './index.js'

        v.exports.boop = (message, cb) ->
            node = document.createTextNode "boop #{message}\n"

            rpc.appendChild node

            cb null

        v.invoke 'beep', (err, message) ->
            node = document.createTextNode "#{message}\n"

            rpc.appendChild node

    when 'worker'
        v = new Wurker

        v.exports.beep = (cb) ->
            cb null, "beep #{Date.now()}"

            v.invoke 'boop', Date.now(), ->

    else
        throw new Error 'unknown context'
