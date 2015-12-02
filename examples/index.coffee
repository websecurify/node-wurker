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

        v.exports.display_time = (t, cb) ->
            time.innerHTML = "Time is #{t}.\n"

    when 'worker'
        v = new Wurker

        v.exports.beep = (cb) ->
            cb null, "beep #{Date.now()}"

            v.invoke 'boop', Date.now(), ->

        setInterval =>
            v.invoke 'display_time', Date.now(), ->

        , 1

    else
        throw new Error 'unknown context'
