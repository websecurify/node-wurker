module.exports = switch
    when typeof window isnt 'undefined'
        require './window'

    when typeof self isnt 'undefined'
        require './worker'

    else
        throw new Error 'uknown context'
