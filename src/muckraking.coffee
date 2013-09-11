Underscore Muckraking
=====================

A collection of utilities for Underscore.js written as underscore mixins

    _.mixin

####_.resizeToFill(wrapset, containerEl, callback)
Resize an image(s) to fill its container element. If no containing element
is supplied, the element parent is filled. Provide an optional callback to execute after all images in the wrapset have been resized.

        resizeToFill: (wrapset, containerEl, callback) ->

            _.each $(wrapset), (el) ->

                $containerEl = $(_.chain([containerEl, $(el).parent(), window]).compact().first().value())

                fitWidth = $containerEl.outerWidth()
                fitHeight = $containerEl.outerHeight()

                naturalSize = _.getNaturalSize(el)

                elWidth = naturalSize[0]
                elHeight = naturalSize[1]

                while elWidth >= fitWidth and elHeight >= fitHeight
                    elWidth--
                    elHeight--

                $(el).attr
                    'width': elWidth+1
                    'height': elHeight+1
                .css
                    'width': (elWidth+1) + 'px'
                    'height': (elHeight+1) + 'px'
                .addClass 'resized'

            callback(wrapset) unless !_.isFunction callback

#### _.preloadImages(imgEl)
Preload an image(s), and trigger an *imageLoaded* event when complete

        preloadImages: (imgEl) ->
            _.each $(imgEl), (image) ->
                $image = $(image)
                img = new Image();
                img.onload = _.bind ->
                    $image.data
                        'natural-width': img.width
                        'natural-height': img.height
                    $image.addClass 'preloaded'
                    $image.trigger 'imagePreloaded'
                , this
                img.src = $image.attr 'src'


####_.capitalize(str)
Capitalize the first word of a string

        capitalize: (str) ->
            str.charAt(0).toUpperCase() + str.substring(1).toLowerCase();


####_.log(message, trace)
Log a message to the debug console. Suppress trace messages by specifying trace=false

        log: (message, trace) ->

            try
                console.log message
                console.trace() unless !trace
            catch err

####_.inArray(array, value)
Check if a value is in an array:

        inArray: (arr, val) ->
            return _.contains(array, val)


####_.quoteVal(val)
Surround a value in quotes and return the value as a string

        quoteVal: (val) ->
            _.template '"<%= val >"', {'val', val}

####_.formatCurrency(val)
Add a dollar sign to a number or string and add a comma as the thousandths seperator

        formatCurrency: (number) ->
            val = number.toString().split('')
            val.splice(1,0,',')
            '$' + val.join('')


####_.default(val, defaultVal)
Return defaultVal if val is null or undefined

        default: (val, defaultVal) ->
            return defaultVal if (_.isNull(val) || _.isUndefined(val) || _.isEmpty(val))
            val


####_.inViewport(el)
Return true if the top-left corner of el is within the viewport. Otherwise, return false.
Method taken from John Resig in this [Stack Overflow]("http://stackoverflow.com/questions/123999/how-to-tell-if-a-dom-element-is-visible-in-the-current-viewport") question.

        inViewport: (el) ->
            elBounds = el.getBoundingClientRect()

            (
                elBounds.top >= 0 and
                elBounds.left >= 0 and
                elBounds.top <= (window.innerHeight || document.documentElement.clientHeight) and
                elBounds.left <= (window.innerWidth || document. documentElement.clientWidth)
            )


