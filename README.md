Underscore Muckraking
=====================

A collection of utilities for Underscore.js

    _.mixin

        inArray: (arr, val) ->
            (_.indexOf(arr, val) > -1)

        quoteVal: (val) ->
            _.template '"<%= val >"', {'val', val}