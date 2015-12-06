Wurker = require 'wurker'

switch Wurker.context
    when 'window'
        v = new Wurker './index.js'

        v.exports.boop = (message, done) ->
            node = document.createTextNode "boop #{message}\n"

            rpc.appendChild node

            done null

        v.invoke 'beep', (err, message) ->
            node = document.createTextNode "#{message}\n"

            rpc.appendChild node

        v.exports.display_time = (t, done) ->
            time.innerHTML = "Time is #{t}.\n"

            done null

    when 'worker'
        v = new Wurker

        v.exports.beep = (done) ->
            done null, "beep #{Date.now()}"

            v.invoke 'boop', Date.now()

        setInterval =>
            v.invoke 'display_time', Date.now()

        , 1

    else
        throw new Error 'unknown context'
